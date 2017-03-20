class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])&.authenticate(params[:session][:password])
    if @user
      session[:user_id] = @user.id
        flash[:success] = "Welcome, #{@user.name}"
      redirect_to :root
    else
      flash[:danger] = "Username or password is incorrect. Please try again."
      redirect_to :login
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
