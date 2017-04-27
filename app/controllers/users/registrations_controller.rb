class Users::RegistrationsController < Devise::RegistrationsController

  def edit
    render layout: "account"
  end

  def new
  	@user = User.new(user_params)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private
  def user_params
  	params.permit(:email, :name)
  end
end