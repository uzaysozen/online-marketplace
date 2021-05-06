class AdminController < ApplicationController
  before_action { authorize! :access, :admin_panel }
  # GET admin/moderation
  def moderation
    @pending_listings = Listing.includes(:creator).where(listing_status: ListingStatus.find_by(name: 'Pending'))
    @pending_listings = @pending_listings.where.not(creator: current_user)
  end

  # GET admin/statistics
  def statistics
    # Get date from params, if it doesn't exist or is blank then use 1 month ago and today.
    @filter_start_date = stats_params[:startdate]&.to_date || Date.today.months_ago(1)
    @filter_end_date = stats_params[:enddate]&.to_date || Date.today

    @filter_group_by_options = [
      'Hour',
      'Day',
      'Week',
      'Month'
    ]
    @filter_group_by = stats_params[:groupby] || @filter_group_by_options[1]

    # Make sure that the end date is not before the start date.
    @filter_end_date = @filter_start_date if @filter_end_date < @filter_start_date

    # Create a date filter, add 1 to the end date so we get that day as well, rather than excluding it.
    date_filter = { created_at: @filter_start_date..@filter_end_date + 1 }

    # Group data based on option selected.
    @listing_view_data =
      case @filter_group_by
      when 'Hour'
        ListingView.where(date_filter).group_by_hour(:created_at).count
      when 'Day'
        ListingView.where(date_filter).group_by_day(:created_at).count
      when 'Week'
        ListingView.where(date_filter).group_by_week(:created_at).count
      else
        ListingView.where(date_filter).group_by_month(:created_at).count
      end
  end

  # GET admin/other
  def other
    @banned_users = User.where(is_banned: true)
    @admins = User.where(administrator: true)
    @questions = PageContent.where(key: 'Question')
    words = PageContent.find_by(key: 'Banned Words')
    covid_guidance = PageContent.find_by(key: 'Covid Guidance')
    @covid_message = if covid_guidance.present?
      covid_guidance.content[0]
                     else
      nil
                     end

    @banned_words = if words.present?
      words.content
                    else
      []
                    end
  end

  def site_settings
    bulk_email = params[:bulk_email]
    banned_words = params[:banned_words]
    covid_guidance = params[:covid_guidance]

    if bulk_email.present?
      User.all.each_slice(50) do |users|
        UserMailer.send_bulk_email(users.map(&:email), bulk_email[:content]).deliver
      end
      redirect_to other_path, notice: "The announcement has been sent to all user."

    elsif banned_words.present?
      banned_words[:content].delete("")
      page_content = PageContent.all.find_or_create_by(key: "Banned Words")
      page_content.update(content: banned_words[:content])

    elsif covid_guidance.present?
      page_content = PageContent.all.find_or_create_by(key: "Covid Guidance")
      page_content.update(content: [covid_guidance[:content]])
    end
  end

  def get_admin
    render layout: false
  end

  def get_question
    render layout: false
  end

  def promote
    username = params[:new_admin][:username]
    email = params[:new_admin][:email]
    new_admin = User.find_by(username: username, email: email)
    @admin = new_admin
    if new_admin.present?
      if new_admin.administrator?
        render 'failure'
      else
        new_admin.update(administrator: true)
        render 'load_user'
      end
    else
      render 'failure'
    end
  end

  def demote
    admin_id = params[:admin][:id]
    admin = User.find(admin_id)
    admin.update(administrator: false)
  end

  def add_question
    question = params[:new_question][:question]
    answer = params[:new_question][:answer]
    if question == "" and answer == ""
      render 'failure'
    else
      @question = PageContent.create(key: 'Question', content: [question, answer])
      render 'load_question'
    end
  end

  def remove_question
    question_id = params[:question][:id]
    page_content = PageContent.find(question_id)
    page_content.destroy
  end

  def approve_listing
    @listing = Listing.find(params[:listing])
    active_status = ListingStatus.find(2)
    @listing.update(listing_status: active_status)
    redirect_to moderation_path, notice: 'Listing approved.'
  end

  def get_user
    @user = User.find(params[:user])
    render layout: false
  end

  def ban_user
    @user = User.find(params[:user][:id])
    if params[:user][:ban_reason] != ""
      @user.update(is_banned: true, ban_reason: params[:user][:ban_reason])
      render 'user_banned'
    end
  end

  def unban_user
    @user = User.find(params[:user][:id])
    @user.update(is_banned: false)
  end

  private
  def stats_params
    params.reject{|_, v| v.blank?}
  end
end
