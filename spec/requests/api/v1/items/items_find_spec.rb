require 'rails_helper'

RSpec.describe 'Items Find API' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create(:item, unit_price: 15.00, name: 'Banana', merchant_id: @merchant1.id)
    @item2 = create(:item, unit_price: 3.00, name: 'Asparagus', merchant_id: @merchant1.id)
    @item3 = create(:item, unit_price: 8.00, name: 'Cheese', merchant_id: @merchant1.id)
    @item4 = create(:item, unit_price: 30.00, name: 'Dingo', merchant_id: @merchant2.id)
    @item5 = create(:item, unit_price: 65.50, name: 'Banjo', merchant_id: @merchant2.id)
  end

  it 'sends an item based on search params name' do
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

  it 'sends an item based on search params min_price and max_price' do
    get api_v1_items_find_path(min_price: 10)
    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(item[:attributes][:name]).to eq(@item1.name)

    get api_v1_items_find_path(max_price: 10)
    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(item[:attributes][:name]).to eq(@item3.name)

    get api_v1_items_find_path(min_price: 26.50, max_price: 30.76)
    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(item[:attributes][:name]).to eq(@item4.name)

    get api_v1_items_find_path(min_price: 36.50, max_price: 30.76)
    JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response.status).to eq(400)

    get api_v1_items_find_path(min_price: '')

    expect(response.status).to eq(400)

    get api_v1_items_find_path

    expect(response.status).to eq(400)
  end
end
