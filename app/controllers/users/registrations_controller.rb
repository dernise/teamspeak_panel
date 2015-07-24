class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper

  before_action :require_user_signed_in

  def create
    super
  end

  def new
    super
  end

  def edit
    super
  end
end
