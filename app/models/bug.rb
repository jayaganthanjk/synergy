class Bug < ActiveRecord::Base
	validates_presence_of :description
	belongs_to :story
	has_many :comments, as: :owner
end
