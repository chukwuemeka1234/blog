class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find(params[:user_id]) if params[:user_id]
  end
end
