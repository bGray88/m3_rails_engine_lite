class Api::V1::Items::FindByPriceController < ApplicationController
  include Find

  def show
    if (params[:min_price] || params[:max_price]) && !params[:name]
      if (bad_params?(:min_price) && bad_params?(:max_price)) ||
         (!params[:max_price].nil? && (params[:min_price].to_i > params[:max_price].to_i))
        render json: ErrorSerializer.error_search('item'), status: :bad_request
      else
        render_item_json(find_by_price(price_range(params[:min_price], params[:max_price])))
      end
    else
      render json: ErrorSerializer.error_search('item'), status: :bad_request
    end
  end
end
