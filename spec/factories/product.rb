FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product name #{n}" }

    price { 1000 }

    stock_quantity  { 10 }

    image_binary { Base64.encode64(Rails.root.join('spec/fixtures/products/320x240.jpg').binread) }

    association :owner, factory: :user
  end
end
