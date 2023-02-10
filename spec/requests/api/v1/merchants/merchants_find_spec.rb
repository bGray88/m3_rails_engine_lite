require 'rails_helper'

RSpec.describe 'Merchants Find API' do
  before(:each) do
    @merchant1 = create(:merchant, name: 'Bob Bobbington')
    @merchant2 = create(:merchant, name: 'Sal Sallington')
    @merchant3 = create(:merchant, name: 'Jenn Jennington')
    @merchant4 = create(:merchant, name: 'Bill Billington')
    @merchant5 = create(:merchant, name: 'Frances Bacon')
  end

  it 'sends a list of merchants' do
    get api_v1_merchants_find_all_path(name: 'bob')
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(merchants[0][:attributes][:name]).to eq('Bob Bobbington')

    get api_v1_merchants_find_all_path(name: 'ton')
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(merchants[0][:attributes][:name]).to eq('Bill Billington')
    expect(merchants[1][:attributes][:name]).to eq('Bob Bobbington')
    expect(merchants[2][:attributes][:name]).to eq('Jenn Jennington')
    expect(merchants[3][:attributes][:name]).to eq('Sal Sallington')

    get api_v1_merchants_find_all_path(name: '')

    expect(response.status).to eq(400)

    get api_v1_items_find_path

    expect(response.status).to eq(400)
  end
end
