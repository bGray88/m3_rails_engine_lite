class Api::V1::Merchants::FindAllController < ApplicationController
  include Find

  def show
    raise ParamError.new(details: 'Query is empty or invalid') if bad_params?(:name)

    merchants = Merchant.find_merchants_by_name(params[:name])

    raise ParamError.new(details: 'Query is empty or invalid') unless merchants

    render json: MerchantSerializer.format_merchants(merchants)
  end
end
