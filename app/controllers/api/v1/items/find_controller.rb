class Api::V1::Items::FindController < ApplicationController
  include Find

  def show
    render json: ErrorSerializer.error_search('item'), status: :bad_request
  end
end
