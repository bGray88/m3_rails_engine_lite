class ItemSerializer
  def self.format_items(items)
    {
      data: items.map do |item|
        {
          id: item.id.to_s,
          type: item.class.to_s.downcase,
          attributes: {
            name: item.name,
            description: item.description,
            unit_price: item.unit_price,
            merchant_id: item.merchant_id
          }
        }
      end
    }
  end

  def self.format_item(item)
    {
      data:
        {
          id: item.id.to_s,
          type: item.class.to_s.downcase,
          attributes: {
            name: item.name,
            description: item.description,
            unit_price: item.unit_price,
            merchant_id: item.merchant_id
          }
        }
    }
  end

  def self.format_empty
    {
      data:
        {}
    }
  end
end
