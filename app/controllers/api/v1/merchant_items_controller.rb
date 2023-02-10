class Api::V1::MerchantItemsController < ApplicationController
  before_action :find_merchant, only: [:index]

  def index
    raise RecordError.new(message: 'Item not found', details: 'Unable to process display', status: :not_found) unless @merchant

    render json: ItemSerializer.format_items(@merchant.items)
  end

  private

  def find_merchant
    @merchant = Merchant.find_by(id: params[:merchant_id])
  end
end
