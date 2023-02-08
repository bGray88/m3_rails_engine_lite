class ErrorSerializer
  def self.error_search(object_type)
    {
      message: 'your query could not be completed',
        errors: [
          "#{object_type} search yields no results"
        ]
    }
  end

  def self.errors_all(errors)
    {
      message: 'your action could not be completed',
        errors: 
          errors.map do |error|
            error
          end
    }
  end
end
