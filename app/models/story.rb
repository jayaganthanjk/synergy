class Story < ActiveRecord::Base
	validates_presence_of :name
	belongs_to :project
	belongs_to :sprint
	has_many :tasks
	has_many :bugs
	has_many :comments, as: :owner

	def self.search(query)
		where("name like ?", "%#{query}%") 
	end
end
