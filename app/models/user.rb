# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: %i[github]

  has_many :posts, dependent: :destroy
  has_one_attached :photo
  has_one_attached :header_photo

  # 自分がフォローしているユーザたち
  has_many :following_status, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy,
                              inverse_of: 'follower'
  has_many :followees, through: :following_status, source: :followee

  # 自分がフォローされているユーザたち
  has_many :followed_status, class_name: 'Follow', foreign_key: :followee_id, dependent: :destroy,
                             inverse_of: 'followee'
  has_many :followers, through: :followed_status, source: :follower

  with_options presence: true do
    validates :name
    validates :user_name, uniqueness: true
    # 電話番号と誕生日はGithubでの新規登録時には無効化する。
    validates :phone, unless: -> { validation_context == :omniauth }
    validates :birthdate, unless: -> { validation_context == :omniauth }
  end

  def self.from_omniauth(auth)
    find_or_initialize_by(provider: auth.provider, uid: auth.uid) do |u|
      u.email = auth.info.email
      u.password = Devise.friendly_token[0, 20]
      u.name = auth.info.name
      u.user_name = auth.info.nickname
    end
  end

  before_save do
    set_dummy_photo(self)
  end

  private

  def set_dummy_photo(user)
    user.photo.attach(io: File.open(Rails.root.join("app/assets/images/dummy_photo.jpg")),
                      filename: "dummy_photo.jpg") unless user.photo.attached?
    user.header_photo.attach(io: File.open(Rails.root.join("app/assets/images/dummy_header_photo.jpg")),
                      filename: "dummy_header_photo.jpg") unless user.header_photo.attached?
  end
end
