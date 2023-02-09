class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :invoice_items, dependent: :delete_all
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.delete_empties(invoices)
    invoices.each do |invoice|
      unless InvoiceItem.only_one_on_invoice(invoice.id).empty?
        Invoice.find(invoice[:id]).destroy
      end
    end
  end
end
