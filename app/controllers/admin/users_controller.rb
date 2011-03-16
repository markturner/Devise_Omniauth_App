class Admin::UsersController < Admin::AdminController
  respond_to :html, :xml
  before_filter :admin_user?

  def index
    respond_with :admin, @users = User.all
  end

  def show
    respond_with :admin, @user = User.find(params[:id])
  end

  def edit
    respond_with :admin, @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    flash[:notice] = 'User was successfully updated.' if @user.update_attributes(params[:user])
    respond_with :admin, @user
  end
  
  def destroy
    @user = User.find(params[:id])
    flash[:notice] = 'User was successfully deleted.' if @user.destroy
    respond_with :admin, @user
  end
end
