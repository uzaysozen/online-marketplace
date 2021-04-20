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
      redirect_to moderation_path
    elsif covid_guidance.present?
      redirect_to moderation_path
    end
  end

  def get_admin
    render layout: false
  end

  def promote
    username = params[:new_admin][:username]
    email = params[:new_admin][:email]
    new_admin = User.find_by(username: username, email: email)
    if new_admin.present?
      if new_admin.administrator?
        redirect_to other_path, notice: 'User is already an admin.'
      else
        new_admin.update(administrator: true)
        redirect_to other_path, notice: 'Admin succesfully added.'
      end
    else
      redirect_to other_path, notice: 'There are no users with the username and email.'
    end
  end

  def demote
    username = params[:admin][:username]
    email = params[:admin][:email]
    admin = User.find_by(username: username, email: email)
    admin.update(administrator: false)
    redirect_to other_path, notice: 'Admin succesfully removed.'
  end

end
