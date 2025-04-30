class User < ApplicationRecord
  belongs_to :chronotype, optional: true
  has_many :user_answers
  has_many :user_chronotypes
  has_many :schedules, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { provider.present? }

  def latest_chronotype_id
    latest_user_chronotype&.chronotype_id
  end

  def latest_user_chronotype
    user_chronotypes.order(created_at: :desc).first
  end

  def default_schedules
    DefaultSchedule.where(chronotype_id: latest_chronotype_id)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
end
