class Admin::AdminController < ApplicationController
  private

  def admin_user?
    if current_user
      unless current_user.admin?
        flash[:error] = "You don't have the authority to access this page"
        redirect_to home_path
        false
      end
    else
      flash[:error] = "You must login to view this page"
      redirect_to login_path
    end
  end
    
end