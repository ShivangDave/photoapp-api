class Api::V1::Like < ApplicationRecord
    has_one :post_like, class_name: 'Api::V1::PostLike', dependent: :destroy
    has_one :post, through: :post_like
    has_one :profile, through: :post_like
end
