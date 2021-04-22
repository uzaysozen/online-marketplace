class AdminController < ApplicationController
  load_and_authorize_resource :class => false
  
  # GET admin/moderation
  def moderation
  end
  
  # GET admin/statistics
  def statistics
  end
  
  # GET admin/other
  def other 
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

end
