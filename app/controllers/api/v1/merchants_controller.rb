class Api::V1::MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show]

  def index
    render json: MerchantSerializer.format_merchants(Merchant.all)
  end

  def show
    render json: MerchantSerializer.format_merchant(@merchant)
  end

  private

  def find_merchant
    @merchant = Merchant.find_by(id: params[:id])
  end
end
