class TasksController < ApplicationController
  authorize_resource
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @story = Story.find params[:story_id]
    @tasks = @story.tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @project = Project.find params[:project_id]
    @story = Story.find params[:story_id]
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @project = Project.find params[:project_id]
    @story = Story.find params[:story_id]
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.project_id = params[:project_id]
    @task.story_id = params[:story_id]
    respond_to do |format|
      if @task.save
        activity = @task.create_activity :create, owner: current_user, recipient: Project.find(@task.project_id)
        
        format.html { redirect_to project_story_tasks_path(project_id: @task.project_id, story_id: @task.story_id), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_story_tasks_path(project_id: @task.project_id, story_id: @task.story_id), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_state
    task = Task.find(params[:task_id])
    state = params[:state]
    case state
      when "Not Started" then task.not_started
      when "In Progress" then task.start
      when "Done" then task.development_done
    end
    render :text => state.to_json
  end

  def findusers
    story = Story.find(params[:id])
    users = story.project.users
    returndata = ""
    users.each do |user|
      returndata = "#{user.email}:#{user.id},#{returndata}"
    end
    render :text => returndata.to_json
  end

  def assigntask
    task = Task.find(params[:task_id])
    task.user_id = params[:user_id]
    task.save
    activity = task.create_activity :assign, owner: current_user, recipient: Project.find(Story.find(task.story_id).project_id)
    @notif = Notification.new
    @notif.notifs_create(task, activity.id)
    render :text => task.to_json
  end

  def change_due_date
    returndata = params[:due_date]
    task = Task.find(params[:story_id])
    task.update_attributes(:due_date => params[:due_date])
    render :text => params[:story_id].to_json
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    story_id = @task.story_id
    project_id = @task.project_id
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_story_tasks_path(project_id: :project_id, story_id: :story_id), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name,:due_date,:estimated_time)
    end
end
