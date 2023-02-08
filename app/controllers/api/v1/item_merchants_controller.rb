class Api::V1::ItemMerchantsController < ApplicationController
  before_action :find_item, only: [:show]

  def show
    if @item
      render json: MerchantSerializer.format_merchant(@item.merchant)
    else
      render json: ErrorSerializer.errors_all([:no_content]), status: :not_found
    end
  end

  private

  def find_item
    @item = Item.find_by(id: params[:item_id])
  end
end
