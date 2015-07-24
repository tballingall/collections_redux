#
class ImagesController < ApplicationController
  before_action :require_login, except: [:show]
  before_action :ensure_current_user, except: [:show, :index]
  before_action :check_admin, only: [:index]
  def new
    @image = album.images.new
  end

  def index
    @images = Image.all.paginate(page: params[:page], per_page: '10')
  end

  def show
    @image = Image.find(params[:id])
  end

  def create
    @image = album.images.new(image_params)
    if @image.save
      flash[:success] = 'Success!'
      redirect_to album_path(album)
    else
      render 'new'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to images_path
  end

  def cover
    # @image = @album.images.find(params[:id])
    album.update_attributes(cover: image)
    redirect_to album_path(album)
  end

  def flagged
    @image = Image.find(params[:id])
    @image.toggle!(flagged)
    flash[:success] = 'Flagged!'
    redirect_to images_path
  end



  private

  def album
    return image.album unless params[:album_id].present?
    @album ||= Album.find(params[:album_id])
  end

  def image
    @_image ||= Image.find(params[:id])
  end

  # def user
  #   album.user
  # end

  def image_params
    params.require(:image).permit(:name, :description, :year, :color, :image)
  end
end
