class Api::V1::PostComment < ApplicationRecord
   belongs_to :post, class_name: 'Api::V1::Post'
   belongs_to :profile, class_name: 'Api::V1::Profile'
   belongs_to :comment, class_name: 'Api::V1::Comment', dependent: :destroy

   validates :post_id, :profile_id, :comment_id, presence: true
end
