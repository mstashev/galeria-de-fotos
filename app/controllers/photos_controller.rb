class PhotosController < ApplicationController
  before_action :find_photo, only: [:edit, :show, :update, :share, :share_email]
  before_action :require_user, only: [:edit, :show, :update]
  before_action :is_owner, only: [:destroy]

  def index
    @photos = Photo.order(created_at: :desc).page(params[:page])
    @users = User.joins(:photos).order(created_at: :desc).limit(5)
    render 'photos/index.html.erb'
  end

  def new
    @photo = Photo.new
  end

  def show
    # find_photo
  end

  def edit
    # find_photo
  end

  def update
    # find_photo
    if @photo.update(photo_params)
      redirect_to @photo
    else
      render :edit
    end
  end

  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.save
      redirect_to :root
    else
      render :new
    end
  end

  def destroy
    # find_photo
    @photo.destroy
    redirect_to :root
  end

  def share

  end

  def email
    # if params[:share][:email]
    UserMailer.share(params[:id], params[:share][:email]).deliver
    # flash[:success] = "Photo was shared with "
    redirect_to @photo
  end

  private

  def photo_params
    params.require(:photo).permit(:gallery_id, :image, :caption, :name, :email)
  end

  def find_gall
    @photo = Photo.find(params[:id])
  end

  def is_owner
    find_photo
    unless @photo.user == current_user
      flash[:danger] = "You are not the creator of this Photo."
      redirect_to :root
    end
  end
end
