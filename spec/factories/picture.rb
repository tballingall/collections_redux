FactoryGirl.define do
  factory :image do
    association :album
    sequence(:name) { |n| "Not School #{n}" }
    image Rack::Test::UploadedFile.new(
      'spec/support/upload/octo.jpg',
      'image/jpg'
    )
  end
end
