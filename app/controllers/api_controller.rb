class ApiController < ApplicationController
  include Errors::ErrorHandler

  rescue_from Exception, with: :handle_errors

  def handle_errors(exception)
    Rails.logger.error("#{exception.exception}: #{exception}")
    exception_handler(exception)
  end

  private
  def exception_handler(exception)
    case exception
    when ApiValidationError
      render json: { status: 400, message: exception.message }, status: :bad_request
    when ActionController::ParameterMissing
      render json: { status: 400, message: I18n.t('errors.params_missing') }, status: :bad_request
    when ActionDispatch::Http::Parameters::ParseError
      render json: { status: 400, message: I18n.t('errors.params_parsing') }, status: :bad_request
    else
      render json: { status: 500, message: I18n.t('errors.internal_server_error') }, status: :internal_server_error
    end
  end
end
