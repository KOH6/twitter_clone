# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[phone birthdate name user_name])
  end

  private

  def set_user
    @user = user_signed_in? ? current_user : User.new
  end
end
