class GalleriesController < ApplicationController
  before_action :load_gallery, only: [:edit, :show, :update]
  before_action :require_user, only: [:new, :edit, :update]
  before_action :is_owner, only: [:destroy]

  def index
    if current_user
      @galleries = current_user.galleries
      @gallery = Gallery.new unless @galleries.any?
    else
      @galleries = Gallery.order(created_at: :desc).page(params[:page])
      @users = User.joins(:galleries).order(created_at: :desc).limit(5)
      render 'galleries/index.html.erb'
    end
  end

  def home
    @gallery = Gallery.order('created_at desc').first
    render 'galleries/home.html.erb'
  end

  def new
    if current_user
      @gallery = Gallery.new
    else
      flash[:danger] = "You are not logged in."
      redirect_to :root
    end

  end

  def show
    @gallery = Gallery.includes(:photos).find(params[:id])
  end

  def edit
    # load_gallery
  end

  def update
    # load_gallery
    if @gallery.update(gallery_params)
      redirect_to @gallery
    else
      render :edit
    end
  end

  def create
    @gallery = current_user.galleries.new(gallery_params)
    if @gallery.save
      redirect_to :root
    else
      render :new
    end
  end

  def destroy
    # load_gallery
    @gallery.destroy
    redirect_to :root
  end

  private

  def gallery_params
    params.require(:galleries).permit(:user_id, :title, :summary, :email, :main_image, :gallery_id)
  end

  def load_gallery
    @gallery = Gallery.find(params[:id])
  end

  def is_owner
    unless @gallery.user == current_user
      flash[:danger] = "You are not the creator of this Gallery."
      redirect_to :root
    end
  end
end
