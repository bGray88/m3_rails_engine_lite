class Api::V1::ItemsController < ApplicationController
  before_action :find_merchant_and_item, only: [:update]
  before_action :find_item, only: [:show, :destroy]

  def index
    render json: ItemSerializer.format_items(Item.all)
  end

  def show
    if @item
      render json: ItemSerializer.format_item(@item)
    else
      render json: ErrorSerializer.errors_all([:no_content]), status: :not_found
    end
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.format_item(Item.last), status: :created
    else
      render json: ErrorSerializer.errors_all([:no_content]), status: :conflict
    end
  end

  def update
    if @item && item_params[:merchant_id].nil? || @item && @merchant
      Item.update(@item.id, item_params)
      render json: ItemSerializer.format_item(Item.find_by(id: @item.id)), status: :ok
    else
      render json: ErrorSerializer.errors_all([:no_content]), status: :not_found
    end
  end

  def destroy
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
