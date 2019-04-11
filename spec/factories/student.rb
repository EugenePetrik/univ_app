# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :student_with_courses do
      transient do
        courses_count { Faker::Number.between(0, 10) }
      end

      after(:create) do |student, evaluator|
        create_list(:course, evaluator.courses_count, student: student)
      end
    end
  end
end
