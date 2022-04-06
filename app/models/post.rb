class Post < ApplicationRecord
    belongs_to :user
    has_many :comments,dependent: :destroy
    has_many :labellings, dependent: :destroy
    has_many :labels, through: :labellings
    has_many :stocks, dependent: :destroy
    has_many :stocks_users, through: :stocks, source: :user
    validates :image, presence: false
    enum status: { public: 0, private: 1 }, _prefix: true
    mount_uploader :image, ImageUploader
end
