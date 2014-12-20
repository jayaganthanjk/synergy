class Story < ActiveRecord::Base
	validates_presence_of :name
	include PublicActivity::Model
	belongs_to :project
	belongs_to :sprint
	has_many :tasks
	has_many :bugs
	has_many :comments, as: :owner

	state_machine :state, :initial => "Not Started" do
    event :start do
      transition all  => "In Progress"
    end
    event :not_started do
      transition all => "Not Started"
    end
    event :deliver do
      transition all => "Delivered"
    end
    event :accept do
      transition all => "Accepted"
    end
    event :reject do
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
      deliver
      return
    end
  end

end
