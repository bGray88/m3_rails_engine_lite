require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'instance methods' do
    before(:each) do
      @merchant1 = create(:merchant, name: 'Bob Bobbington')
      @merchant2 = create(:merchant, name: 'Sal Sallington')
      @merchant3 = create(:merchant, name: 'Jenn Jennington')
      @merchant4 = create(:merchant, name: 'Bill Billington')
      @merchant5 = create(:merchant, name: 'Frances Bacon')
    end

    describe '#find_merchants' do
      it 'returns first all matches for a case-insensitive alphabetical search ' do
        expect(Merchant.find_merchants_by_name('ton').length).to eq(4)
        expect(Merchant.find_merchants_by_name('ton')[0][:name]).to eq('Bill Billington')
        expect(Merchant.find_merchants_by_name('ton').last[:name]).to eq('Sal Sallington')
        expect(Merchant.find_merchants_by_name('on').length).to eq(5)
        expect(Merchant.find_merchants_by_name('on')[2][:name]).to eq('Frances Bacon')
      end
    end
  end
end
