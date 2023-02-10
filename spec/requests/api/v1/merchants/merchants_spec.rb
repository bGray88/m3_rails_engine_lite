require 'rails_helper'

RSpec.describe 'Merchant API' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)
  end

  it 'sends a list of merchants' do
    get api_v1_merchants_path

    merchants_list = JSON.parse(response.body, symbolize_names: true)[:data]
    merchants_array = [@merchant1, @merchant2, @merchant3, @merchant4, @merchant5]

    expect(response).to be_successful
    expect(merchants_list.length).to eq(5)
    merchants_list.each_with_index do |merchant, index|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant[:attributes][:name]).to eq(merchants_array[index].name)
    end
  end

  it 'sends a single merchant' do
    get api_v1_merchant_path(@merchant1)

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

    expect(merchant[:attributes][:name]).to eq(@merchant1.name)
  end
end
