class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.format_items(merchant.items)
    else
      render json: ItemSerializer.format_items(Item.all)
    end
  end
end
