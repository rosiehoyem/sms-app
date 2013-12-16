# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sm, :class => 'Sms' do
    phone_number "MyString"
    firstname "MyString"
  end
end
