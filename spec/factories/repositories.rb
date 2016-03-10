FactoryGirl.define do
  factory :repository do
    url { Faker::Internet.url }
    public_id { UUID.generate }
  end
end
