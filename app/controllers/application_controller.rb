# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'sha1'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  before_filter :admin_required

  def admin_required
    authenticate_or_request_with_http_basic('hbci4rails Administration') do |username, password|
       username == 'admin' && Digest::SHA1.hexdigest(password) == APP_CONFIG[:admin_password_hash]
     end
  end
end
