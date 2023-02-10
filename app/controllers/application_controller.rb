class ApplicationController < ActionController::API
  rescue_from StandardError::ParamError, with: :error_response_param
  rescue_from StandardError::RecordError, with: :error_response_record

  def error_response_param(error)
    render json: ErrorSerializer.error_json(error), status: 400
  end

  def error_response_record(error)
    render json: ErrorSerializer.error_json(error), status: 404
  end
end
