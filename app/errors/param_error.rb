class ParamError < StandardError

  attr_reader :exception_type,
              :details,
              :status

  def initialize(message = 'Content is Invalid', details = 'Param is Invalid', status = 400)
    @details        = details
    @status         = status
    @exception_type = 'Params'
    super(message)
  end
end
