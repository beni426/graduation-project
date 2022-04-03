class Post < ApplicationRecord
    belongs_to :user
    has_many :comments,dependent: :destroy
    validates :image, presence: false
    mount_uploader :image, ImageUploader
end
