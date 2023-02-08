class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id

  def self.find_item_by_name(search_term)
    where("lower(name) LIKE ?", "%#{search_term.downcase}%").order(name: :asc).limit(1).first
  end

  def self.find_item_by_price(search_range, direction)
    where(unit_price: search_range).order(unit_price: direction).limit(1).first
    # where(name: 'Item A Error').limit(1).first
  end
end
