FactoryBot.define do
  factory :order do
    sequence(:product_name) { |n| "Product name #{n}" }

    product_price { 100 }

    order_quantity { 1 }

    orderer_name { 'Elbert E. Blair' }

    orderer_address { '2670 McKinley Avenue, Englewood, CO 80110' }

    association :orderer, factory: :user

    association :order_receiver, factory: :user
  end
end
