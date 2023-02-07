require 'rails_helper'

RSpec.describe 'Items Find API' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create(:item, name: 'Banana', merchant_id: @merchant1.id)
    @item2 = create(:item, name: 'Asparagus', merchant_id: @merchant1.id)
    @item3 = create(:item, name: 'Cheese', merchant_id: @merchant1.id)
    @item4 = create(:item, name: 'Dingo', merchant_id: @merchant2.id)
    @item5 = create(:item, name: 'Banjo', merchant_id: @merchant2.id)
  end

  it 'sends a list of a merchant\'s items' do
    get api_v1_items_find_path(name: 'Banjo')
    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(item[:attributes][:name]).to eq('Banjo')

    get api_v1_items_find_path(name: 'baN')
    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(item[:attributes][:name]).to eq('Banana')

    get api_v1_items_find_path(name: 'ngo')
    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(item[:attributes][:name]).to eq('Dingo')

    get api_v1_items_find_path(name: '')

    expect(response.status).to eq(400)

    get api_v1_items_find_path

    expect(response.status).to eq(400)
  end
end
