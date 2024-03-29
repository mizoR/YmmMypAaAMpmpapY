FactoryBot.define do
  factory :user do
    sequence(:email)                 { |n| "email#{n}@example.com" }

    sequence(:password)              { |n| "password#{n}" }

    sequence(:password_confirmation) { |n| "password#{n}" }
  end
end
