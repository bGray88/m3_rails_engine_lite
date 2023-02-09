require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'instance methods' do
    before(:each) do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)

      @item1 = create(:item, unit_price: 15.00, name: 'Banana', merchant_id: @merchant1.id)
      @item2 = create(:item, unit_price: 3.00, name: 'Asparagus', merchant_id: @merchant1.id)
      @item3 = create(:item, unit_price: 8.00, name: 'Cheese', merchant_id: @merchant1.id)
      @item4 = create(:item, unit_price: 30.00, name: 'Dingo', merchant_id: @merchant2.id)
      @item5 = create(:item, unit_price: 65.50, name: 'Banjo', merchant_id: @merchant2.id)
    end

    describe '#find_item_by_name' do
      it 'returns first element of case-insensitive alphabetical search ' do
        expect(Item.find_item_by_name('banjo')[:name]).to eq('Banjo')
        expect(Item.find_item_by_name('aspAraGus')[:name]).to eq('Asparagus')
        expect(Item.find_item_by_name('ban')[:name]).to eq('Banana')
      end
    end

    describe '#find_item_by_price' do
      it 'returns first element of a numerical search ' do
        expect(Item.find_item_by_price(10..15.00, :asc)[:name]).to eq('Banana')
        expect(Item.find_item_by_price(20..35.00, :desc)[:name]).to eq('Dingo')
        expect(Item.find_item_by_price(0..70.00, :asc)[:name]).to eq('Asparagus')
      end
    end
  end
end
