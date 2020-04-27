class Api::V1::Follow < ApplicationRecord
    belongs_to :follower, class_name: 'Api::V1::User'
    belongs_to :followee, class_name: 'Api::V1::User'
end
