class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[firstname lastname])
  end

  def record_not_found
    redirect_to :root, alert: generate_error_message('Object not found')
  end

  def generate_error_message(errors)
    "Error in #{params[:controller]}##{params[:action]}: #{errors.is_a?(Array) ? errors.join(',') : errors}"
  end
end
