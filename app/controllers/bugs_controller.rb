class BugsController < ApplicationController
  authorize_resource
  before_action :set_bug, only: [:show, :edit, :update, :destroy]

  # GET /bugs/new
  def new
    @story = Story.find params[:story_id] 
    @bug = Bug.new
  end


  # POST /bugs
  # POST /bugs.json
  def create
    @bug = Bug.new(bug_params)
    @bug.user_id = current_user.id
    respond_to do |format|
      if @bug.save
        activity = @bug.create_activity :create, owner: current_user, recipient: Project.find(@bug.story.project_id)
        format.html { redirect_to project_story_tasks_path(project_id: @bug.story.project_id, story_id: @bug.story_id), notice: 'Bug was successfully created.' }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

 
  # DELETE /bugs/1
  # DELETE /bugs/1.json
  def destroy
    @bug.destroy
    respond_to do |format|
      format.html { redirect_to project_story_tasks_path(project_id: @bug.story.project_id, story_id: @bug.story_id), notice: 'Bug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bug_params
      params.require(:bug).permit(:content, :story_id)
    end
end
