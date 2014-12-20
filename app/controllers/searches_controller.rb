class SearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.search(params[:search].downcase).order("created_at DESC").where(archive: false) 
    @sprints  = Sprint.search(params[:search].downcase).order("created_at DESC").where(archive: false) 
    @stories  = Story.search(params[:search].downcase).order("created_at DESC").where(archive: false) 
    @tasks = Task.search(params[:search].downcase).order("created_at DESC").where(archive: false) 
  end

end
