class AdminController < ApplicationController
  
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

end
