class HomeController < ApplicationController
	def index
    render "projects/index"
	end

  def findUsers
    users = User.all
    render :text => users.to_json( only: [:email] )
  end
end