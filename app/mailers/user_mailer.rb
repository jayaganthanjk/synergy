class UserMailer < ActionMailer::Base
  default from: "notifications@synergy.com"

  def signup_confirmation(user)
  	@user = user
		mail to: @user.email, subject: 'Thank you for signing up with Synergy!!'
	end

	def assinged_role(user, project, role, by)
		@user = user 
		@project = project 
		@by = by
		@role = role
		mail to: @user.email, subject: 'Assigned role!!' do |format|
			format.html { "assined role go check notifications!!" }
		end
	end
end
