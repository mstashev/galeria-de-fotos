class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :show, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_self, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    # find_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.signup(@user).deliver
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    # find_user
  end

  def update
    # find_user
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    session[:user_id] = nil
    @user.destroy
    redirect_to :root
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :password, :profile_pic, :email)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def require_self
    unless @user == current_user
      flash[:danger] = "You are unauthorized to change this persons details"
      redirect_to :root
    end
  end
end
