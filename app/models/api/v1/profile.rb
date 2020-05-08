class Api::V1::Profile < ApplicationRecord

    # Friendly ID Settings => Look up users using slug
    extend FriendlyId
    friendly_id :_id, use: :slugged
    
    # User Model Association
    belongs_to :user, class_name: 'Api::V1::User'

    # Follow Model Association
    has_many :followed_users, foreign_key: :follower_id, class_name: 'Api::V1::Follow', dependent: :destroy
    has_many :followees, through: :followed_users

    has_many :following_users, foreign_key: :followee_id, class_name: 'Api::V1::Follow', dependent: :destroy
    has_many :followers, through: :following_users
    
    # Post Model Association
    has_many :posts, class_name: 'Api::V1::Post', dependent: :destroy
    
    # Like Model Association ( User is Liking posts)
    has_many :create_like, foreign_key: :profile_id, class_name: 'Api::V1::PostLike', dependent: :destroy
    has_many :liked_items, through: :create_like, source: :like, dependent: :destroy

    # Profile Model Validations
    validates :slug, :user_id, { :presence => true, :uniqueness => { :case_sensitive => false } }
    validates :profile_name, :presence => true
end
