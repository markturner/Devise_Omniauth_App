class AuthenticationsController < ApplicationController
  def index
    @auths = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
    flash[:notice] = "Authentication successful"
    redirect_to authentications_url
  end

  def destroy
    @auth = current_user.authentications.find(params[:id])
    @auth.destroy
    flash[:notice] = "Successfully deleted authentication"
    redirect_to authentications_url
  end

end
