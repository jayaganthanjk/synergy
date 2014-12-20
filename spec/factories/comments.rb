FactoryGirl.define do
  factory :comment do
    user_id 1
content "MyText"
owner_id 1
owner_type "MyString"
  end

end
