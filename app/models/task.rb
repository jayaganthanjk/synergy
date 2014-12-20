class Task < ActiveRecord::Base
	validates_presence_of :name
	belongs_to :project
	belongs_to :story
	has_many :timelogs
	include PublicActivity::Model

	state_machine :state, :initial => "Not Started" do
    after_transition any => any, :do => :story_update
    event :start do
      transition all => "In Progress"
    end
    event :development_done do
      transition all => "Done"
    end
    event :not_started do
      transition all => "Not Started"
    end
  end

	def self.search(query)
		where("name like ?", "%#{query}%")
	end

	def story_update
    story.update_status rescue nil
  end
end
