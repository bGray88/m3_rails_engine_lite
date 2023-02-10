class Api::V1::MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show]

  def index
    render json: MerchantSerializer.format_merchants(Merchant.all)
  end

  def show
    raise RecordError.new(message: 'Item not found', details: 'Unable to process display', status: :not_found) unless @merchant

    render json: MerchantSerializer.format_merchant(@merchant)
  end

  private

  def find_merchant
    @merchant = Merchant.find_by(id: params[:id])
  end
end
