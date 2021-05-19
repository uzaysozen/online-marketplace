class AdminController < ApplicationController
  before_action { authorize! :access, :admin_panel }
  # GET admin/moderation
  def moderation
    @pending_listings = Listing.includes(:creator).where(listing_status: ListingStatus.find_by(name: 'Pending'))
    @pending_listings = @pending_listings.where.not(creator: current_user)
  end

  # GET admin/statistics
  def statistics; end

  # GET admin/other
  def other
    @banned_users = User.where(is_banned: true)
    @admins = User.where(administrator: true)
    @questions = PageContent.where(key: 'Question')
    words = PageContent.find_by(key: 'Banned Words')
    covid_guidance = PageContent.find_by(key: 'Covid Guidance')
    if covid_guidance.present?
      @covid_message = covid_guidance.content[0]
    else
      @covid_message = nil
    end

    if words.present?
      @banned_words = words.content
    else
      @banned_words = []
    end
  end

  def site_settings
    bulk_email = params[:bulk_email]
    banned_words = params[:banned_words]
    covid_guidance = params[:covid_guidance]

    if bulk_email.present?
      User.all.each_slice(50) do |users|
        UserMailer.send_bulk_email(users.map(&:email), "SU Marketplace Announcement", bulk_email[:content]).deliver
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
    # Notify users who want notifications immediately
    users_to_notify = User.where("'#{@listing.listing_category.id}' = ANY (user_categories)")
    users_to_notify = users_to_notify.where(when: 'immediately', email_category: true)
    users_to_notify.each_slice(50) do |users|
      UserMailer.send_bulk_email(users.map(&:email), "SU Marketplace Notification", 
      "Hi #{users.map(&:givenname)[0]},\n\n#{@listing.creator.username} just posted #{@listing.title} in #{@listing.listing_category.name} category. Check it out before someone buys it!").deliver
    end
  end

  def get_user
    @user = User.find(params[:user])
    render layout: false
  end

  def ban_user
    @user = User.find(params[:user][:id])
    if params[:user][:ban_reason] != ""
      @user.update(is_banned: true, ban_reason: params[:user][:ban_reason])
      if params[:user][:report].present?
        render 'user_banned_report'
      else
        render 'user_banned'
      end
    end
  end

  def unban_user
    @user = User.find(params[:user][:id])
    @user.update(is_banned: false)
  end

  def user_view
    @users = User.where(administrator: false).or(User.where(administrator: nil))
    # Sorting Function
    table_col = @users.column_names
    sort_val = ['asc', 'desc']

    # Verifying Parameters
    if table_col.include? params[:sort] and sort_val.include? session[:sort_order]
      sort_order = session[:sort_order] || 'asc'
      @users = session[:sort_users] ||= User.where(administrator: false).or(User.where(administrator: nil))
      @users = @users.order("#{params[:sort]} #{sort_order}")
      session[:sort_order] = sort_order == 'asc' ? 'desc' : 'asc'
    else
      params[:sort] = "givenname"
      sort_order = 'asc'
      @users = session[:sort_users] ||= User.where(administrator: false).or(User.where(administrator: nil))
      @users = @users.order("#{params[:sort]} #{sort_order}")
      session[:sort_order] = sort_order == 'asc' ? 'desc' : 'asc'
    end
  end

  def view_listings
    @user_listings = User.find(params[:user]).user_listings
    render layout: false
  end
  
end
