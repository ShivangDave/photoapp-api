class Api::V1::Comment < ApplicationRecord
    has_one :post_comment, class_name: 'Api::V1::PostComment', dependent: :destroy
    has_one :post, through: :post_comment
    has_one :profile, through: :post_comment

    validates :body, presence: true
end
