require 'rails_helper'

RSpec.describe 'Merchant Items API' do
  describe 'CRUD' do
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
      get api_v1_items_path

      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(items[:data].length).to eq(5)
      items[:data].each do |item|
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
      end
    end

    it 'sends a single item' do
      get api_v1_item_path(@item1)

      item = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
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
    end

    it 'can create a new item' do
      item_params = ({
        name: 'Wild Turkey',
        description: 'A good product, and thorough',
        unit_price: 42.99,
        merchant_id: @merchant1.id
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)
      created_item = Item.last

      expect(response).to be_successful
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
    end

    it "can update an existing item" do
      id = create(:item, name: "Hungry Man Deluxe").id
      previous_name = Item.last.name
      headers = { "CONTENT_TYPE" => "application/json" }

      patch api_v1_item_path(id), headers: headers, params: JSON.generate({ name: "Hungry Man Excessive" })
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("Hungry Man Excessive")
    end

    it 'can return an item\'s merchant' do
      get api_v1_item_merchant_path(@item1)
      merchant = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(merchant[:id]).to eq(@merchant1.id.to_s)
      expect(merchant[:attributes][:name]).to eq(@merchant1.name)

      get api_v1_item_merchant_path(@item4)
      merchant = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(merchant[:id]).to eq(@merchant2.id.to_s)
      expect(merchant[:attributes][:name]).to eq(@merchant2.name)
    end

    it "can destroy an item and associated invoice if only item" do
      @invoice1 = create(:invoice)
      @invoice2 = create(:invoice)
      @invoice3 = create(:invoice)

      @invoice_item1 = create(:invoice_item, item: @item1)
      @invoice_item2 = create(:invoice_item, item: @item2)
      @invoice_item3 = create(:invoice_item, item: @item3)
      @invoice_item4 = create(:invoice_item, item: @item1)

      @invoice1.invoice_items << @invoice_item1
      @invoice1.invoice_items << @invoice_item2
      @invoice2.invoice_items << @invoice_item3
      @invoice3.invoice_items << @invoice_item4

      expect { delete api_v1_item_path(@item1) }.to change(Item, :count).by(-1)

      expect(response).to be_successful
      expect { Item.find(@item1.id) }.to raise_error(ActiveRecord::RecordNotFound)

      expect(Item.count).to eq(4)

      delete api_v1_item_path(@item3)
      expect { Invoice.find(@invoice2.id) }.to raise_error(ActiveRecord::RecordNotFound)

      expect(Item.count).to eq(3)
      expect(Invoice.count).to eq(5)
    end
  end
end
