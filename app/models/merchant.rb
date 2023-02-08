class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name

  def self.find_merchants_by_name(search_term)
    where("lower(name) LIKE ?", "%#{search_term.downcase}%").order(name: :asc)
  end
end
