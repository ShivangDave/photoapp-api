class Api::V1::Post < ApplicationRecord

    belongs_to :profile, class_name: 'Api::V1::Profile'
    has_many :post_likes, class_name: 'Api::V1::PostLike', dependent: :destroy
    has_many :likes, through: :post_likes, dependent: :destroy
    
    has_many :post_comment, class_name: 'Api::V1::PostComment', dependent: :destroy
    has_many :comments, through: :post_comment, dependent: :destroy

end
