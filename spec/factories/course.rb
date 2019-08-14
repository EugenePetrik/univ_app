# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    short_name { Faker::Lorem.characters(rand(3..15)).upcase }
    description { Faker::Lorem.paragraph_by_chars(rand(10..300)) }
  end
end
