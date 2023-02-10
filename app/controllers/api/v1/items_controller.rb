class Api::V1::ItemsController < ApplicationController
  before_action :find_merchant_and_item, only: [:update]
  before_action :find_item, only: [:show, :destroy]

  def index
    render json: ItemSerializer.format_items(Item.all)
  end

  def show
    raise RecordError.new(message: 'Item not found', details: 'Unable to process display', status: :not_found) unless @item

    render json: ItemSerializer.format_item(@item)
  end

  def create
    item = Item.new(item_params)
    raise RecordError.new(message: 'Item not saved', details: 'Unable to process create', status: :not_found) unless item.save

    render json: ItemSerializer.format_item(Item.last), status: :created
  end

  def update
    raise RecordError.new(message: 'Item not found', details: 'Unable to process update', status: :not_found) unless @item && item_params[:merchant_id].nil? || @item && @merchant

    Item.update(@item.id, item_params)
    render json: ItemSerializer.format_item(Item.find_by(id: @item.id)), status: :ok
  end

  def destroy
    Invoice.delete_empties(@item.invoices)
    @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :unit_price,
      :merchant_id
    )
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def find_merchant_and_item
    @merchant = Merchant.find_by(id: params[:merchant_id])
    @item     = Item.find_by(id: params[:id])
  end
end
