class PagesController < ApplicationController

  skip_before_action :authenticate_user!

  def home
    @current_nav_identifier = :home
    covid_content = PageContent.find_by(key: 'Covid Guidance')
    if covid_content.present?
      @covid_guidance = covid_content.content
    else
      @covid_guidance = nil
    end
  end

  def admin
    @current_nav_identifier = :admin
  end

  # GET pages/about
  def about
    @current_nav_identifier = :about
  end

  # GET pages/terms
  def terms
    @current_nav_identifier = :terms
  end

  # GET pages/faq
  def faq
    @current_nav_identifier = :faq
    @questions = PageContent.where(key: 'Question')
  end
  
  # GET pages/contact
  def contact
    @current_nav_identifier = :contact
  end

  # POST pages/contact
  def contact_mail
    contact = params[:contact]
    UserMailer.contact_email(contact[:email], contact[:name], contact[:message]).deliver
    redirect_to contact_path , notice: 'Your message has been sent.'
  end

end