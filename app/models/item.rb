class Item < ApplicationRecord

  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id

  belongs_to :merchant
  has_many :invoice_items, dependent: :delete_all
  has_many :invoices, through: :invoice_items

  def self.find_item_by_name(search_term)
    where("lower(name) LIKE ?", "%#{search_term.downcase}%").order(name: :asc).limit(1).first
  end

  def self.find_item_by_price(search_range, direction)
    where(unit_price: search_range).order(name: direction).limit(1).first
  end
end
