class PagesController < ApplicationController

  skip_authorization_check

  def home
    @current_nav_identifier = :home
  end

  def admin
    @current_nav_identifier = :admin
  end

  # GET pages/terms
  def terms
    @current_nav_identifier = :terms
  end

  # GET pages/faq
  def faq
    @current_nav_identifier = :faq
  end
  
  # GET pages/contact
  def contact
    @current_nav_identifier = :contact
  end

  # POST pages/contact
  def contact_mail
    contact = params[:contact]
    UserMailer.contact_email(contact[:email], contact[:name], contact[:message]).deliver
    redirect_to pages_contact_path , notice: 'Your message has been sent.'
  end

end
