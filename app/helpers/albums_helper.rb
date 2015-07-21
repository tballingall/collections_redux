#
module AlbumsHelper
  def update_album_link(album)
    return update_album_link!(album) if permitted?(album.user)
    ''
  end

  def create_cover_link(image)
    return '' unless permitted?(image.user)
    return '' if image.album.cover?(image)
    create_cover_link!(image)
  end

  private

  def create_cover_link!(image)
    link_to 'Make Primary', cover_image_path(image)
  end

  def update_album_link!(album)
    link_to edit_album_path(album)
  end
end
