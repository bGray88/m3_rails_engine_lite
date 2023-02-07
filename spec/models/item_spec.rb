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
  end

  describe 'instance methods' do
    before(:each) do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)

      @item1 = create(:item, name: 'Banana', merchant_id: @merchant1.id)
      @item2 = create(:item, name: 'Asparagus', merchant_id: @merchant1.id)
      @item3 = create(:item, name: 'Cheese', merchant_id: @merchant1.id)
      @item4 = create(:item, name: 'Dingo', merchant_id: @merchant2.id)
      @item5 = create(:item, name: 'Banjo', merchant_id: @merchant2.id)
    end

    describe '#find_item' do
      it 'returns first element of case-insensitive alphabetical search ' do
        expect(Item.find_item('banjo')[:name]).to eq('Banjo')
        expect(Item.find_item('aspAraGus')[:name]).to eq('Asparagus')
        expect(Item.find_item('ban')[:name]).to eq('Banana')
      end
    end
  end
end
