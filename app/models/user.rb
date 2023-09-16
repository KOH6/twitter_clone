# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: %i[github]

  with_options presence: true do
    validates :name
    validates :user_name, uniqueness: true
    # 電話番号と誕生日はGithubでの新規登録時には無効化する。
    validates :phone, unless: -> { validation_context == :omniauth }
    validates :birthdate, unless: -> { validation_context == :omniauth }
  end

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid) do |user|
      p "auth.info"
      p auth.info
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.user_name = auth.info.nickname
    end
    user.new_record? ? user.save(context: :omniauth) : user
  end
end
