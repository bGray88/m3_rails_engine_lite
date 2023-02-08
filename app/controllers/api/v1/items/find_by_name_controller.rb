class Api::V1::Items::FindByNameController < ApplicationController
  include Find

  def show
    if params[:name] && !(params[:min_price] || params[:max_price])
      if bad_params?(:name)
        render json: ErrorSerializer.error_search('item'), status: :bad_request
      else
        render_item_json(find_by_name(params[:name]))
      end
    else
      render json: ErrorSerializer.error_search('item'), status: :bad_request
    end
  end
end
