# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
      name "MyString"
      description "MyText"
      live false
      channel "MyString"
      status "MyString"
    end
end