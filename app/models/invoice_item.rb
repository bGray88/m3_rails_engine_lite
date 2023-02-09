class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price

  belongs_to :invoice
  belongs_to :item

  def self.only_one_on_invoice(invoice_id)
    self.joins(:invoice)
        .where('invoice_id = ?', invoice_id)
        .select('invoices.*, count(*) as count')
        .group('invoice_id, invoices.id')
        .having('count(*) = ?', 1)
  end
end
