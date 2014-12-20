class Comment < ActiveRecord::Base
	validates_presence_of :content
	belongs_to :owner, :polymorphic => true
end
