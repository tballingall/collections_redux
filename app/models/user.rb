#
class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  extend Dragonfly::Model
  field :name, type: String
  field :email, type: String
  field :password_digest, type: String
  field :created_at, type: DateTime
  field :updated, type: DateTime
  field :image_uid, type: String
  field :image_name, type: String
  field :album_uid, type: String
  field :admin, type: Boolean, default: false
  has_secure_password
  has_many :albums
  has_many :images
  accepts_nested_attributes_for :albums
  dragonfly_accessor :image

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
            presence: true,
            uniqueness: { case_sensitive: false }

  # query: Return a null user object
  #
  # Returns a Struct which responds to id, email, username, and authenticate
  #
  # @return [User] User duck
  #
  def self.null_user
    NullUser.new
  end

  # User duck type for null user pattern
  #
  class NullUser
    attr_reader :id, :email, :username
  end
end
