class InvitationsController < Devise::InvitationsController
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def update
    super
  end

  private
  def configure_permitted_parameters
  	# Only add some parameters
  	devise_parameter_sanitizer.for(:accept_invitation).concat [:name]
	end
end