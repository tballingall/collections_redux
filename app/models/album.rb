#
class Album
  include Mongoid::Document
  field :name, type: String
  field :user_id, type: String
  field :image_id, type: String
  belongs_to :user
  belongs_to :cover, class_name: "Image"
  has_many :images
  delegate :thumb_url, to: :cover, allow_nil: true

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false, scope: :user_id }

  # query: Returns whether the given image is the cover for this album
  #
  # @return [Boolean]
  # stolen
  #
  def cover?(image)
    cover == image
  end
end
