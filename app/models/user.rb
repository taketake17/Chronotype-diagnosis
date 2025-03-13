class User < ApplicationRecord
  has_many :user_answers
  has_many :user_chronotypes
  has_many :schedules, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
