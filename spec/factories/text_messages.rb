# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :text_message, :class => 'TextMessage' do
    phone_number { Faker::PhoneNumber.phone_number }
    firstname { Faker::Name.first_name }
  end
end
