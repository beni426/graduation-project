class Post < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { in: 0..50 } 
  validates :description, presence: true
  validates :description, length: { in: 0..500 } 
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  has_many :stocks, dependent: :destroy
  has_many :stocks_users, through: :stocks, source: :user
  validates :image, presence: true
  enum status: { public: 0, private: 1 }, _prefix: true
  has_many :votes, dependent: :destroy
  has_many :vote_users, through: :votes,source: :user
  mount_uploader :image, ImageUploader

  
end
