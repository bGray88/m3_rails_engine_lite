class Api::V1::Items::FindController < ApplicationController
  include Find

  def show
    render json: { errors: 'Missing required parameters' }, status: :bad_request
  end
end
