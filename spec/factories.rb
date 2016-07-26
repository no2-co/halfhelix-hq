FactoryGirl.define do
  factory :project do
    title "MyString"
    description "MyText"
    status "MyString"
    valid_till "2016-07-26 17:29:30"
    discount 1.5
    notes "MyText"
    terms "MyText"
    code "MyString"
  end
  factory :client do
    name "MyString"
    address "MyString"
    phone "MyString"
    email "MyString"
  end
  factory :admin_user do
    
  end
end
