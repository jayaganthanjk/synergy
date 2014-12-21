class Project < ActiveRecord::Base
	resourcify
	include PublicActivity::Model
	activist
	validates_presence_of :name, :start, :end
	has_many :sprints
	has_many :stories
	has_many :tasks
	has_many :users , through: :roles

	def self.search(query)
		where("name like ?", "%#{query}%") 
	end

	def users
    User.all.select { |user| user.can? :read, self }
  end
end
