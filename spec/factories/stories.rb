FactoryGirl.define do
  factory :story do
    name "MyString"
		description "MyText"
		sprint_id 1
		project_id 1
		state "MyString"
		due_date "2014-12-20 11:34:22"
		archive false
  end

end
