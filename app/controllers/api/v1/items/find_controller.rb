class Api::V1::Items::FindController < ApplicationController
  def show
    if params[:name] && !(params[:min_price] || params[:max_price])
      if bad_params?(:name)
        render json: { errors: "Name is of an invalid arrangement" }, status: :bad_request
      else
        render_item_json(find_by_name(params[:name]))
      end
    elsif (params[:min_price] || params[:max_price]) && !params[:name]
      if (bad_params?(:min_price) && bad_params?(:max_price)) ||
         (!params[:max_price].nil? && (params[:min_price].to_i > params[:max_price].to_i))
        render json: { errors: "Price is of an invalid arrangement" }, status: :bad_request
      else
        render_item_json(find_by_price(price_range(params[:min_price], params[:max_price])))
      end
    else
      render json: { errors: "Not cool" }, status: :bad_request
    end
  end

  private

  def bad_params?(key)
    !params.key?(key) || params[key].empty? ||
      params[key].to_i < 0 || params[key].to_i < 0
  end

  def price_range(min, max)
    return [0.01..max.to_f, :desc] if min.nil?
    return [min.to_f..Float::INFINITY, :asc] if max.nil?
    return [min.to_f..max.to_f, :asc]
  end

  def find_by_price(search)
    Item.find_item_by_price(search[0], search[1])
  end

  def find_by_name(search_term)
    Item.find_item_by_name(search_term)
  end

  def render_item_json(item)
    if item
      render json: ItemSerializer.format_item(item)
    else
      render json: ErrorSerializer.error_item_search
    end
  end
end
