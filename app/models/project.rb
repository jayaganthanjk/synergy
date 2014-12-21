class Project < ActiveRecord::Base
	resourcify
	include PublicActivity::Model
	activist
	validates_presence_of :name, :start, :end
	has_many :sprints
	has_many :stories
	has_many :tasks
	has_many :users , through: :roles
	has_many :uploads

	def self.search(query)
		where("name like ?", "%#{query}%") 
	end

	def users
    User.all.select { |user| user.can? :read, self }
  end

  def progress
		done=0; current=0; total = 0;
		self.stories.each do |story|
			a, b, c = story.progress
			done+=a; current+=b; total+=c;
		end
		return done, current, total
  end
  
	def backlog_stories
		self.stories.where(state: "Not Started")
	end

	def rest_stories
		self.stories.where.not(state: "Not Started")
	end

	def completed_stories
		self.stories.where(state: "Delivered")
	end

	def project_user_roles user
    user.roles.where(:resource_id => self.id)
  end

end
