FactoryBot.define do
  factory :tutor do
    name { Faker::Name.name }
    course { build(:course) }
  end
end
