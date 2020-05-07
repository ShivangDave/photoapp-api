class Api::V1::Follow < ApplicationRecord
    belongs_to :follower, class_name: 'Api::V1::Profile'
    belongs_to :followee, class_name: 'Api::V1::Profile'
end
