FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "person#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'this is a very secure password'
    password_confirmation 'this is a very secure password'
    factory :admin do
      admin true
    end
  end
end
