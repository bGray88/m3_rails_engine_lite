class Api::V1::Items::FindByPriceController < ApplicationController
  include Find

  def show
    raise ParamError.new(details: 'Query is empty or invalid') if bad_params?(:min_price) && bad_params?(:max_price)
    raise ParamError.new(details: 'Query is empty or invalid') if invalid_price_range?(params[:min_price], params[:max_price])

    item = Item.find_item_by_price(price_range(params[:min_price], params[:max_price]))
    render_item_json(item)
  end
end
