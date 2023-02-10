class Api::V1::ItemMerchantsController < ApplicationController
  before_action :find_item, only: [:show]

  def show
    raise RecordError.new(message: 'Item not found', details: 'Unable to process display', status: :not_found) unless @item

    render json: MerchantSerializer.format_merchant(@item.merchant)
  end

  private

  def find_item
    @item = Item.find_by(id: params[:item_id])
  end
end
