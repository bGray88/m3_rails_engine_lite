module Find
  def bad_params?(key)
    !params.key?(key) || params[key].empty? ||
      params[key].to_i.negative? || params[key].to_i.negative?
  end

  def invalid_price_range?(min, max)
    !max.nil? && (min.to_i > max.to_i)
  end

  def price_range(min, max)
    return { range: 0.01..max.to_f, direction: :desc } if min.nil?
    return { range: min.to_f..Float::INFINITY, direction: :asc } if max.nil?
    return { range: min.to_f..max.to_f, direction: :asc }
  end

  def render_item_json(item)
    if item
      render json: ItemSerializer.format_item(item)
    else
      render json: ItemSerializer.format_empty
    end
  end
end
