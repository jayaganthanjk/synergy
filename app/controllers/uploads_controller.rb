class UploadsController < ApplicationController

	def create
		@upload = Upload.new(upload_params)
		if @upload.save
			redirect_to project_path(id: @upload.project_id), notice: 'Upload was saved succesfully!'
		else
			redirect_to project_path(id: @upload.project_id), alert: 'Upload was not saved!'
		end
	end

	private

	def upload_params
		params.require(:upload).permit(:name, :project_id, :user_id, :link, :remote_link_url)
	end

end
