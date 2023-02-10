require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
  end

  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
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
    end

    describe '#only_one_on_invoice' do
      it 'returns invoice_item if only one invoice_item is occupying invoice or empty array if not' do
        expect(InvoiceItem.only_one_on_invoice(@invoice1.id)).to eq([])
        expect(InvoiceItem.only_one_on_invoice(@invoice2.id)).to eq([@invoice_item2])
        expect(InvoiceItem.only_one_on_invoice(@invoice3.id)).to eq([@invoice_item3])
      end
    end
  end
end
