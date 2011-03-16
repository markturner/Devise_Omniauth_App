class AuthenticationsController < ApplicationController
  def index
    @auths = current_user.authentications if current_user
  end
    
  def create
    # this is complicated... check the comments below
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication   
      # sign in if service associated with logged out user
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user  
      # add service to current logged in user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to account_url
    else
      if user = User.find_by_email(omniauth['user_info']['email'])  
        # check if user exists and associate service and log them in if so (fix for google 'email already taken' bug)
        user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
        flash[:notice] = "Authentication successful."
        sign_in(:user, user)
        redirect_to account_url
      else  
        # if user doesn't exist, register new user
        user = User.new
        user.apply_omniauth(omniauth)
        if user.save
          flash[:notice] = "Signed in successfully."
          sign_in_and_redirect(:user, user)
        else
          session[:omniauth] = omniauth.except('extra')
          redirect_to new_user_registration_url
        end
      end
    end
  end

  def destroy
    @auth = current_user.authentications.find(params[:id])
    @auth.destroy
    flash[:notice] = "Successfully deleted authentication"
    redirect_to account_url
  end

end
