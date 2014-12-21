class NotificationsController < ApplicationController
	def index
		@notifications = current_user.notifications.order('created_at desc')
	end

	def seen
		@notif = Notification.find(params[:id])
		@notif.seen = true
		@notif.save
		render :text => @notif.seen.to_json
	end

	def seen_all
		current_user.unseen_notifs.each do |notif|
			notif.seen = true
			notif.save
		end
		respond_to do |format|
			format.html { render :text => current_user.unseen_notifs.count.to_json }
			format.js 
		end
	end

	def request_role
		respond_to do |format|
			superadmins = User.with_role(:super_admin)
			superadmins.each do |sup|
				@notif = sup.notifications.create(user_id: sup.id)
				@notif.save
				activity = @notif.create_activity :request_role, owner: current_user, recipient: sup
				@notif.update_attributes(activity_id: activity.id)
			end
		
			format.html { redirect_to :back, :notice => 'Sent a request to the super admin!'  }
			format.js { render 'request_role.js.erb' }
		end
	end

end
