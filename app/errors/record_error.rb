class RecordError < StandardError

  attr_reader :exception_type,
              :details,
              :status

  def initialize(message = 'Content is Invalid', details = 'Record is Invalid', status = 400)
    @details        = details
    @status         = status
    @exception_type = 'Records'
    super(message)
  end
end
