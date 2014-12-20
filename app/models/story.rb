class Story < ActiveRecord::Base
	validates_presence_of :name
	include PublicActivity::Model
	belongs_to :project
	belongs_to :sprint
	has_many :tasks
	has_many :bugs
	has_many :comments, as: :owner

	state_machine :initial => "Not Started" do
    event :start do
      transition all  => "In Progress"
    end
    event :not_started do
      transition all => "Not Started"
    end
    event :all_tasks_done do
      transition all => "Code Review"
    end
    event :code_reviewed do
      transition all  => "Testing"
    end
    event :qa_passed do
      transition all => "Deploy"
    end
    event :deployed do
      transition all => "Delivered"
    end
    event :accepted do
      transition all => "Accepted"
    end
    event :reworking do
      transition 'Delivered' => 'Reworking'
    end
    event :rejected do
      transition all => "Rejected"
    end
  end

	def self.search(query)
		where("name like ?", "%#{query}%") 
	end

	 def update_status
    tasks_statuses = self.tasks.map(&:state)
    tasks_statuses = tasks_statuses.uniq
    if tasks_statuses.include? 'In Progress'
      start
      return
    end
    if tasks_statuses == ['Not Started']
      not_started
      return
    end
    if tasks_statuses == ['Done']
      all_tasks_done
      return
    end
  end

end
