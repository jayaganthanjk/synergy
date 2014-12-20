class Sprint < ActiveRecord::Base
	validates_presence_of :name
	belongs_to :project
	has_many :stories
	include PublicActivity::Model

	def self.search(query)
		where("name like ?", "%#{query}%") 
	end	
end
