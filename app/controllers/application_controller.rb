class ApplicationController < ActionController::Base

  def is_user_operator?
    redirect_to root_path if current_user.operator.blank?
  end
end
