class Api::V1::Merchants::FindAllController < ApplicationController
  def show
    if !params.has_key?(:name) || params[:name].empty?
      render json: :no_content, status: :bad_request
    else
      merchants = Merchant.find_merchants_by_name(params[:name])
      if merchants
        render json: MerchantSerializer.format_merchants(merchants)
      else
        render json: ErrorSerializer.error_search('merchant')
      end
    end
  end
end
