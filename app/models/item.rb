class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id

  def self.find_item(search_term)
    where("lower(name) LIKE ?", "%#{search_term.downcase}%").order(name: :asc).limit(1).first
  end
end
