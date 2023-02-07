class ErrorSerializer
  def self.error_item_search
    {
      data:
        {
          message: "item search yields no results"
        }
    }
  end

  def self.error_merchant_search
    {
      data:
        {
          message: "merchant search yields no results"
        }
    }
  end
end
