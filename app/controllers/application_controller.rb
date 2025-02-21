class ApplicationController < ActionController::Base
  before_action :authenticate_user! # Require login by default

  # Allow username and monthly_budget during sign-up and updates
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :monthly_budget])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :monthly_budget])
  end

  # Redirect to login page after sign-up instead of auto-login
  def after_sign_up_path_for(resource)
    new_user_session_path # Redirect to login page
  end
end
