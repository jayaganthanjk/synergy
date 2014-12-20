class Bug < ActiveRecord::Base
	validates_presence_of :content, :user_id
  belongs_to :user
	belongs_to :story
	has_many :comments, as: :owner
	include PublicActivity::Model

	state_machine :initial => "Open" do
    event :close do
      transition all  => "Closed"
    end
    event :openit do
      transition all => "Open"
    end
    event :fix do
      transition all => "Fixed"
    end
  end
end
