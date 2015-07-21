FactoryGirl.define do
  factory :album do
    association :user
    sequence(:name) { |n| "Not School #{n}" }
  end
end
