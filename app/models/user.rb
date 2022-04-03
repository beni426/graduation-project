class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true, length: {maximum: 20}, uniqueness: true
  validates :email, presence: true, length: {maximum: 255},
      format: {with: /\A[\w.!#$%&'*+\/=?^`{|}~-]+@[\w.-]+\.[\w-]+\z/i},
      uniqueness: true
    # before_validation {email.downcase!}
   
    validates :password, length: {minimum: 6}, allow_nil: true
  attr_accessor :email, :password, :password_confirmation, :remember_me,:name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
end
