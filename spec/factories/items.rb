FactoryBot.define do
  factory :item do
    name { Faker::Food.ingredient }
    description { Faker::Food.description }
    unit_price { Faker::Number.between(from: 0.10, to: 100.00) }
    merchant
  end
end
