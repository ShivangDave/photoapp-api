class Api::V1::Post < ApplicationRecord
    belongs_to :profile, class_name: 'Api::V1::Profile'
end
