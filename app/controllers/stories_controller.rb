class StoriesController < ApplicationController
  authorize_resource
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.all
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
  end

  # GET /stories/new
  def new
    @project = Project.find params[:project_id]
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
    @project = Project.find(params[:project_id])
    @story = Story.find params[:id]
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    @story.project_id = params[:project_id]

    respond_to do |format|
      if @story.save
        activity = @story.create_activity :create, owner: current_user, recipient: Project.find(@story.project_id)
        @notif = Notification.new
        @notif.notifs_create(@story, activity.id) 
        format.html { redirect_to  project_path(id: @story.project_id), notice: 'Story was successfully created.' }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to project_path(id: @story.project_id), notice: 'Story was successfully updated.' }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    story = Story.find(params[:id])
    respond_to do |format|
      if story.accept
        format.html { redirect_to completedstories_project_path(id: story.project_id), notice: 'Accepted story' }
      end
    end
  end
  
  def next_state
    story = Story.find(params[:id])
    story.next_state(params[:state])
    activity = story.create_activity :next_state, owner: current_user, recipient: Project.find(story.project_id)
    @notif = Notification.new
    @notif.notifs_create(story, activity.id)
    render :text => story.state.to_json
  end

  def accept_story
    story = Story.find(params[:id])
    story.accepted
    story[:description] = params[:description]
    story.save
    flash[:notice] = "Story Accepted!"
    redirect_to :back
  end
  

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to project_path(id: @story.project_id), notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:name, :description, :due_date)
    end
end
