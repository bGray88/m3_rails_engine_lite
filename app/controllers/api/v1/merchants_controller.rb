class Api::V1::MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show]

  def index
    render json: MerchantSerializer.format_merchants(Merchant.all)
  end

  def show
    if @merchant
      render json: MerchantSerializer.format_merchant(@merchant)
    else
      render json: :no_content, status: :not_found
    end
  end

  private

  def find_merchant
    @merchant = Merchant.find_by(id: params[:id])
  end
end
