class Upload < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
	validates_presence_of :name, :project_id, :user_id, :link
	mount_uploader :link, FileUploader
end
