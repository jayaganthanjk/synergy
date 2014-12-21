class ProjectsController < ApplicationController
  authorize_resource
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.order('created_at DESC')
    @activities = PublicActivity::Activity.where(recipient: current_user).order('created_at desc')
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        activity = @project.create_activity :create, owner: current_user, recipient: current_user
        @notif = Notification.new
        @notif.notifs_create(@project, activity.id) 
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def resource
    @project = Project.find params[:id]
  end

  def addUser
    @user = User.find_by_email params[:email]
    role = params[:role]
    @project = Project.find params[:id]
    role = role.to_sym
    respond_to do |format|
      if @user.add_role(role,@project)
        UserMailer.assinged_role(@user, @project, role, current_user).deliver
        format.html { redirect_to resource_project_path(@project), notice: 'successfully assinged user with role to this project'}
      end 
    end
  end

  def completedstories
    @stories = Project.find(params[:id]).stories.where(state: 'Delivered' )
    @delivered_stories = Project.find(params[:id]).stories.where(state: 'Accepted' )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :start, :end)
    end
end
