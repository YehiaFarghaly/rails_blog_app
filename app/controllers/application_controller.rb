
class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound do |e|
    render_error(e.message, :not_found)
  end
  rescue_from ActiveRecord::RecordInvalid do |e|
    render_error(e.record.errors.full_messages, :unprocessable_entity)
  end
  rescue_from ActionController::ParameterMissing do |e|
    render_error(e.message, :bad_request)
  end

  protected

  def render_error(message, status)
    render json: { error: message }, status: status
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name image])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name image])
  end
end