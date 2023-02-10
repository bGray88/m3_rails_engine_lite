class Api::V1::Items::FindByNameController < ApplicationController
  include Find

  def show
    raise ParamError.new(details: 'Query is empty or invalid') if bad_params?(:name)

    render_item_json(Item.find_item_by_name(params[:name]))
  end
end
