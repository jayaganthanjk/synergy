class UserMailer < ActionMailer::Base
  default from: "notifications@synergy.com"

  def signup_confirmation(user)
		@user = user
		mail to: @user.email, subject: 'Thank you for signing up with Synergycon!!'
	end
end
