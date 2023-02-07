class Api::V1::MerchantItemsController < ApplicationController
  before_action :find_merchant_and_item, only: [:update]
  before_action :find_merchant, only: [:index]

  def index
    if @merchant
      render json: ItemSerializer.format_items(@merchant.items)
    else
      render json: :no_content, status: :not_found
    end
  end

  private

  def find_merchant_and_item
    @merchant = Merchant.find_by(id: params[:merchant_id])
    @item     = Item.find_by(id: params[:id])
  end

  def find_merchant
    @merchant = Merchant.find_by(id: params[:merchant_id])
  end
end