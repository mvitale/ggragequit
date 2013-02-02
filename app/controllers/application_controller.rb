class ApplicationController < ActionController::Base
  before_filter :check_login

  helper_method :current_user

  protect_from_forgery

  protected

  def current_user
    @current_user ||= User.find_by_username(session[:username])
  end

  private 

  def check_login 
    puts request.path
    redirect_to login_url unless current_user or login_request?
  end

  def login_request?
    request.path == login_path
  end
end
