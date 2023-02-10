class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  def self.find_merchants_by_name(search_term)
    where("name ILIKE ?", "%#{search_term.downcase}%").order('lower(name) asc')
  end
end
