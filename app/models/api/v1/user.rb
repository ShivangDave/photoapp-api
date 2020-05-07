class Api::V1::User < ApplicationRecord
  has_secure_password

  has_one :profile, class_name: 'Api::V1::Profile', dependent: :destroy

  has_many :followers, through: :profile
  has_many :followees, through: :profile

  validates :username, :password, :email, :presence => true
  validates :username, :email, :uniqueness => { :case_sensitive => false }
  validates :email, :email => true

  after_create :add_slug_and_id

  @VISIBLE_PUBLIC_ATTR = [:username, :profile_name, :location]
  @VISIBLE_SELF_ATTR = [:username, :profile_name, :location, :email]

  def json_profile
    self.as_json(
      except: [
        :password_digest
      ],
      include: [
        :followers,
        :followees
      ]
    ).merge(
      self.profile.as_json(
        except: [
          :user_id
        ]
      )
    )
  end

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

  def add_slug_and_id
    self.create_profile(
      _id: JWT.encode({
          user_id: self.id
        },
        ENV['SUPER_SECRET_USER_KEY']
      ).split('.').join('$'),
      profile_name: self.username
    )
    # self.profile._id = JWT.encode({user_id: self.id},ENV['SUPER_SECRET_USER_KEY']).split('.').join('$')
  end

end
