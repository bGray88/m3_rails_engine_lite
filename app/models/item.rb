class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id

  belongs_to :merchant
  has_many :invoice_items, dependent: :delete_all
  has_many :invoices, through: :invoice_items

  def self.find_item_by_name(search_term)
    where("name ILIKE ?", "%#{search_term.downcase}%").order('lower(name) asc').limit(1).first
  end

  def self.find_item_by_price(range_direction)
    where(unit_price: range_direction[:range]).order(name: range_direction[:direction]).limit(1).first
  end
end
