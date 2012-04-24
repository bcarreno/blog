# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    login "MyString"
    email "MyString"
    email "MyString"
    name "MyString"
    password_hash "MyString"
    password_salt "MyString"
  end
end
