class Api::V1::MerchantItemsController < ApplicationController
  before_action :find_merchant, only: [:index]

  def index
    if @merchant
      render json: ItemSerializer.format_items(@merchant.items)
    else
      render json: { errors: "Unable to find Merchant by id" }, status: :not_found
    end
  end

  private

  def find_merchant
    @merchant = Merchant.find_by(id: params[:merchant_id])
  end
end
