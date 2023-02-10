class ErrorSerializer
  def self.error_json(error)
    {
      message: error.message,
      errors: [
        details: error.details
      ],
      status: error.status
    }
  end
end
