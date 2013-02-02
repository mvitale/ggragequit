class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    
    puts params[:password]

    puts user

    if user
      session[:username] = user.username
      session[:password_hash] = user.password_hash
      redirect_to root_url
    else
      flash.now.alert = "Invalid username/password"
      render "new"
    end
  end

  def destroy
    session[:username] = nil
    session[:password_hash] = nil
    redirect_to login_url
  end
end
