class HomeController < ApplicationController
	def index
    render "projects/index"
	end

  def findUsers
    users = User.all
    render :text => users.to_json( only: [:email] )
  end

  def analytics
    @tagging = Tagging.new
  end

  def useranalytics
    user = User.find_by_email(params[:email])
    data = user.taggings.group(:tag_id).sum(:duration)
    @user_data = data.map{ |k,v| [Tag.find(k).name,v] }
    binding.pry
    respond_to do |format|
      format.html { render 'analytics' }
    end
  end
end