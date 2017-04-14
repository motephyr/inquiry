class Users::RegistrationsController < Devise::RegistrationsController

  def edit
    render layout: "account"
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end