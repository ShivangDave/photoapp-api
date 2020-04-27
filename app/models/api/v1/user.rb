class Api::V1::User < ApplicationRecord
  has_secure_password

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Api::V1::Follow'
  has_many :followees, through: :followed_users

  has_many :following_users, foreign_key: :followee_id, class_name: 'Api::V1::Follow'
  has_many :followers, through: :following_users

  validates :username, :password, :profile_name, :email, :location, :presence => true
  validates :username, :email, :uniqueness => { :case_sensitive => false }
  validates :email, :email => true

  @VISIBLE_PUBLIC_ATTR = [:username, :profile_name,:location]
  @VISIBLE_SELF_ATTR = [:username, :profile_name, :location, :email]

  def self.profiles
    self.all.as_json(
      only: [
        :id,
        :username,
        :profile_name,
        :location
      ],
      include: {
        followers: {
          only: @VISIBLE_PUBLIC_ATTR,
          include: :followers
        },
        followees: {
          only: @VISIBLE_PUBLIC_ATTR,
          include: :followers
        }
      }
    )
  end

  def profile
    self.as_json(
      only: @VISIBLE_SELF_ATTR,
      include: {
        followers: {
          only: @VISIBLE_PUBLIC_ATTR,
          include: :followers
        },
        followees: {
          only: @VISIBLE_PUBLIC_ATTR,
          include: :followers
        }
      }
    ).merge({ 
      '_id': JWT.encode(
        self.id,
        ENV['SUPER_SECRET_USER_KEY']
      ) 
    })
  end

end
