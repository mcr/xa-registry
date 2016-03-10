FactoryGirl.define do
  factory :rule do
    name { Faker::Hipster.word }
    version { Faker::Number.number(5) }
  end
end
