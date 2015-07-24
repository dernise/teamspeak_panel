class Users::PasswordsController < Devise::PasswordsController
  include ApplicationHelper

  before_action :require_user_signed_in

  def new
    super
  end
end
