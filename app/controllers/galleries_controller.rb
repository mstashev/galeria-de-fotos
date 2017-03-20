class GalleriesController < ApplicationController
  before_action :find_gallery, only: [:edit, :show, :update, :share, :share_email]
  before_action :require_user, only: [:edit, :update]
  before_action :is_owner, only: [:destroy]

  def index
    @galleries = Gallery.order(created_at: :desc).page(params[:page])
    @users = User.joins(:galleries).order(created_at: :desc).limit(5)
    render 'galleries/index.html.erb'
  end

  def home
    @gallery = Gallery.order('created_at desc').first
    render 'galleries/home.html.erb'
  end

  def new
    @gallery = Gallery.new
  end

  def show
    # find_gallery
  end

  def edit
    # find_gallery
  end

  def update
    # find_gallery
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
    # find_gallery
    @gallery.destroy
    redirect_to :root
  end

  def share

  end

  def email
    # if params[:share][:email]
    UserMailer.share(params[:id], params[:share][:email]).deliver
    # flash[:success] = "Gallery was shared with "
    redirect_to @gallery
  end

  private

  def gallery_params
    params.require(:galleries).permit(:user_id, :title, :summary, :email, :main_image)
  end

  def find_gallery
    @gallery = Gallery.find(params[:id])
  end

  def is_owner
    find_gallery
    unless @gallery.user == current_user
      flash[:danger] = "You are not the creator of this Gallery."
      redirect_to :root
    end
  end
end
