FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    short_name { (Faker::Lorem.characters(8)).upcase }
    description { Faker::Lorem.paragraph_by_chars }
  end
end
