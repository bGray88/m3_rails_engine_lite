class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      if Merchant.find_by(id: params[:merchant_id])
        merchant = Merchant.find(params[:merchant_id])
        render json: ItemSerializer.format_items(merchant.items)
      else
        render json: :no_content, status: :not_found
      end
    else
      render json: ItemSerializer.format_items(Item.all)
    end
  end

  def show
    render json: ItemSerializer.format_item(Item.find(params[:id]))
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.format_item(Item.last), status: :created
    end
  end

  def update
    if params[:merchant_id]
      if Merchant.find_by(id: params[:merchant_id])
        if Item.update(params[:id], item_params)
          render json: ItemSerializer.format_item(Item.find(params[:id])), status: :ok
        else
          render json: :no_content, status: :not_found
        end
      else
        render json: :no_content, status: :not_found
      end
    else
      if Item.update(params[:id], item_params)
        render json: ItemSerializer.format_item(Item.find(params[:id])), status: :ok
      else
        render json: :no_content, status: :not_found
      end
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      render json: :no_content, status: :ok
    end
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
end
