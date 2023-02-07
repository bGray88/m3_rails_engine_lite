class Api::V1::Items::FindController < ApplicationController
  def show
    if !params.has_key?(:name) || params[:name].empty?
      render json: :no_content, status: :bad_request
    else
      item = Item.find_item(params[:name])
      if item
        render json: ItemSerializer.format_item(item)
      else
        render json: ErrorSerializer.error_item_search
      end
    end
  end
end
