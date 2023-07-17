FactoryBot.define do
  factory :course do
    title { Faker::Book.title }
    description { Faker::Book.genre }
  end
end
