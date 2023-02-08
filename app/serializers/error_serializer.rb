class ErrorSerializer
  def self.error_search(object_type)
    {
      data:
        {
          message: "#{object_type} search yields no results"
        }
    }
  end
end
