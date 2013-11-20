class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception

  helper_method :current_user

private

  def current_admin_user
    current_user if current_user && current_user.admin?
  end
end
