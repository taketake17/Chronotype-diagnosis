class User < ApplicationRecord
  belongs_to :chronotype, optional: true
  has_many :user_answers
  has_many :user_chronotypes
  has_many :schedules, dependent: :destroy

  def chronotype_id
    user_chronotype&.chronotype_id
  end

  def user_chronotype
    UserChronotype.where(user_id: self.id).order(created_at: :desc).first
  end

  def default_schedules
    DefaultSchedule.where(chronotype_id: self.chronotype_id)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
