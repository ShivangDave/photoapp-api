class Api::V1::User < ApplicationRecord
  has_secure_password

  validates :username, :password, :profile_name, :email, :location, :presence => true
  validates :username, :email, :uniqueness => { :case_sensitive => false }
  validates :email, :email => true

  def self.profiles
    self.all.as_json(
      only: [
        :id,
        :username,
        :profile_name,
        :location
      ]
    )
  end

  def profile
    self.as_json(
      only: [
        :username,
        :profile_name,
        :email,
        :location
      ]
    ).merge({ 
      '_id': JWT.encode(
        self.id,
        ENV['SUPER_SECRET_USER_KEY']
      ) 
    })
  end

end
