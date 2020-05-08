class Api::V1::PostLike < ApplicationRecord
    
   belongs_to :post, class_name: 'Api::V1::Post'
   belongs_to :profile, class_name: 'Api::V1::Profile'
   belongs_to :like, class_name: 'Api::V1::Like', dependent: :destroy

   validates :post_id, :profile_id, :like_id, presence: true
end
