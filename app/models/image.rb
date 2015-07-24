#
class Image
  include Mongoid::Document
  extend Dragonfly::Model
  field :name, type: String
  field :album_id, type: Integer
  field :year, type: Integer
  field :color, type: String
  field :description, type: String
  field :image_uid, type: String
  field :image_name, type: String
  field :flagged, type: Boolean, default: false
  dragonfly_accessor :image
  belongs_to :album
  delegate :user, to: :album
  validates :name, presence: true
  validates :image, presence: :true

  after_create :maybe_primary

  # query: Returns the url for an image thumb (stolen)
  #
  # @return [String]

  def thumb_url
    image.thumb('400x200#').url
  end

  def full_size
    image.thumb('400x400#').url
  end

  private

  def maybe_primary
    return self if album.cover.present?
    album.update_attributes(cover: self)
    self
  end
end
