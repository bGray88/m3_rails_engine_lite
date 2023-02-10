class Api::V1::Items::FindController < ApplicationController
  include Find

  def show
    raise ParamError.new(details: 'Query is empty or invalid')
  end
end
