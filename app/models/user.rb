# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: %i[github]

  with_options presence: true do
    validates :phone
    validates :birthdate
    validates :name
    validates :user_name, uniqueness: true
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      p "auth.info"
      p auth.info
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
