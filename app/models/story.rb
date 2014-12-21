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

  def progress
    total = self.tasks.map(&:estimated_time).reduce(:+).to_f
    current = self.tasks.where(state: 'In Progress').map(&:estimated_time).reduce(:+).to_f
    done = self.tasks.where(state: 'Done').map(&:estimated_time).reduce(:+).to_f
    return done, current, total
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

  def next_state(current_state)
    case current_state
      when "Not Started" then not_started
      when "In Progress" then start
      when "Delivered" then deliver
      when "Accepted" then accept
      when "Reject" then reject
    end
  end

end
