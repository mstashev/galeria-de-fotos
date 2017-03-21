class PhotosController < ApplicationController
  before_action :find_gallery, only: [:new, :edit, :show, :update]
  before_action :find_photo, only: [:edit, :show, :update]
  before_action :require_user, only: [:edit, :show, :update]
  before_action :is_owner, only: [:destroy]

  def index
    @photos = Photo.order(created_at: :desc).page(params[:page])
    @users = User.joins(:photos).order(created_at: :desc).limit(5)
    render 'photos/index.html.erb'
  end

  def new
    if current_user
      @gallery = Gallery.find(params[:gallery_id])
      @photo = Photo.new
    else
      flash[:danger] = "You are not logged in."
      redirect_to :root
    end
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
    if @photo.save!
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

  private

  def photo_params
    params.require(:photo).permit(:gallery_id, :photo, :image, :caption, :name, :email)
  end

  def find_gallery
    @gallery = Gallery.find(params[:gallery_id])
  end

  def find_photo
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
