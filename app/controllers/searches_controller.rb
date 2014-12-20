class SearchesController < ApplicationController

  def index
    @projects = Project.search(params[:search].downcase).order("created_at DESC").where(archive: false) 
    @stories  = Story.search(params[:search].downcase).order("created_at DESC").where(archive: false) 
    @tasks = Task.search(params[:search].downcase).order("created_at DESC").where(archive: false) 
  end

end
