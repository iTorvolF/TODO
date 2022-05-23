# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  before_action do
    I18n.locale = :ru
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email role_id])
  end
end
