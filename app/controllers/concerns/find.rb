module Find
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
      render json: ErrorSerializer.error_search('item')
    end
  end
end
