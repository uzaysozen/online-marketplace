require 'jwt'

class ApplicationController < ActionController::Base
  # Ensure that CanCanCan is correctly configured
  # and authorising actions on each controller
  # check_authorization

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :update_headers_to_disable_caching
  before_action :ie_warning
  before_action :authenticate_user!
  before_action :validate_covid_guidance_date, :set_jwt

  ## The following are used by our Responder service classes so we can access
  ## the instance variable for the current resource easily via a standard method
  def resource_name
    controller_name.demodulize.singularize
  end

  def current_resource
    instance_variable_get(:"@#{resource_name}")
  end

  def current_resource=(val)
    instance_variable_set(:"@#{resource_name}", val)
  end

  # Catch NotFound exceptions and handle them neatly, when URLs are mistyped or mislinked
  rescue_from ActiveRecord::RecordNotFound do
    render template: 'errors/error_404', status: 404
  end
  rescue_from CanCan::AccessDenied do
    render template: 'errors/error_403', status: 403
  end

  # IE over HTTPS will not download if browser caching is off, so allow browser caching when sending files
  def send_file(file, opts = {})
    response.headers['Cache-Control'] = 'private, proxy-revalidate' # Still prevent proxy caching
    response.headers['Pragma'] = 'cache'
    response.headers['Expires'] = '0'
    super(file, opts)
  end

  private

  def update_headers_to_disable_caching
    response.headers['Cache-Control'] = 'no-cache, no-cache="set-cookie", no-store, private, proxy-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '-1'
  end

  def ie_warning
    if request.user_agent.to_s =~ /MSIE [6-7]/ && request.user_agent.to_s !~ %r{Trident/7.0}
      redirect_to(ie_warning_path)
    end
  end

  def validate_covid_guidance_date
    @covid_guidance = PageContent.find_by(key: "Covid Guidance")
    # Check if the user has dismissed the covid guidance and if the updated dates differ.
    if @covid_guidance.present? && cookies[:covid_guidance_date] != @covid_guidance.updated_at.to_s
      # Delete covid guidance cookies if they have to force a refresh of them
      cookies.delete :dismissed_covid_guidance
      cookies.delete :covid_guidance_date
    end
  end

  def set_jwt
    if current_user
      # SET JWT Token on page load to authenticate our requests.
      # Set an expiry of 3 hours from now, this should refresh every time the user moves page so shouldn't be a problem.
      payload = { user_id: current_user.id, exp: Time.now.to_i + (3600 * 3) }
      cookies[:token] = JWT.encode payload, '5|_||>E.-5e(.-e7|<e`/', 'HS256'
    else
      # Delete JWT Token if no current since that means they signed out.
      cookies.delete :token
    end
  end
end