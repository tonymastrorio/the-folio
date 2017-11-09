class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || user_portfolios_path(current_user)
  end

  private

  def require_permission
    if current_user != Portfolio.find(params[:id]).user
        redirect_to root_path
    end
  end   
end
