class UsersController < ApplicationController
  respond_to :html, :xml

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully deleted your account"
    redirect_to root_url
  end
  
end