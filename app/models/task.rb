class Task < ActiveRecord::Base
	validates_presence_of :name
	belongs_to :project
	belongs_to :story
	has_many :timelogs

	def self.search(query)
		where("name like ?", "%#{query}%")
	end
end
