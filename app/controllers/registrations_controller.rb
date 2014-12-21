class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      activity = @user.create_activity :create, owner: current_user
      @notif = Notification.new
      @notif.user_signup(@user, activity.id)
      flash[:notice] ="Signed Up successfullly!"
      redirect_to "/"
    else
      render 'new'
    end
  end

  def update
    super
  end

  private

  #WHY ARE YOU PERMITTING encrypted_password?, should it not be password confirmation
  def user_params
    params.require(:user).permit(:email, :password, :salt, :encrypted_password)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :salt, :encrypted_password, :current_password)
  end
end 