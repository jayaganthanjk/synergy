class Comment < ActiveRecord::Base
	validates_presence_of :content, :owner
	belongs_to :owner, :polymorphic => true
	belongs_to :user
	include PublicActivity::Model
end
