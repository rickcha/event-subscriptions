class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in"
      redirect_to '/'
    else
      flash[:warning] = "Invalid password or username"
      redirect_to '/login'
    end 
  end
  
  def destroy 
    session[:user_id] = nil 
    redirect_to '/' 
  end

end
