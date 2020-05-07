class Api::V1::Profile < ApplicationRecord
    extend FriendlyId
    friendly_id :_id, use: :slugged

    belongs_to :user, class_name: 'Api::V1::User'
    
    has_many :followed_users, foreign_key: :follower_id, class_name: 'Api::V1::Follow', dependent: :destroy
    has_many :followees, through: :followed_users

    has_many :following_users, foreign_key: :followee_id, class_name: 'Api::V1::Follow', dependent: :destroy
    has_many :followers, through: :following_users
end
