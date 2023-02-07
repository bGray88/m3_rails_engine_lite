require 'rails_helper'

RSpec.describe 'Item Merchant API' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
  end

  it 'sends a list of a merchant\'s items' do
    get api_v1_item_merchant_path(@item1)

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to be_a(String)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_a(Hash)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end
end
