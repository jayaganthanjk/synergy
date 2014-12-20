class Project < ActiveRecord::Base
	resourcify
	include PublicActivity::Model
	activist
	validates_presence_of :name, :start, :end
	has_many :sprints
	has_many :stories
	has_many :tasks

	def self.search(query)
		where("name like ?", "%#{query}%") 
	end
end
