require 'rails_helper'

RSpec.describe 'Merchant Items API' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant2.id)
    @item5 = create(:item, merchant_id: @merchant2.id)
  end

  it 'sends a list of a merchant\'s items' do
    get api_v1_merchant_items_path(@merchant1)

    items_list  = JSON.parse(response.body, symbolize_names: true)
    items_array = [@item1, @item2, @item3, @item4, @item5]

    expect(response).to be_successful
    expect(items_list[:data].length).to eq(3)
    items_list[:data].each_with_index do |item, index|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes][:name]).to eq(items_array[index].name)
      expect(item[:attributes][:description]).to eq(items_array[index].description)
      expect(item[:attributes][:unit_price]).to eq(items_array[index].unit_price)
    end
  end
end
