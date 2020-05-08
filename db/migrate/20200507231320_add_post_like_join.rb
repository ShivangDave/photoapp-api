class AddPostLikeJoin < ActiveRecord::Migration[6.0]
  create_table :'api_v1_post_likes' do |t|
    t.references :post, class_name: 'Api::V1::Post'
    t.references :profile, class_name: 'Api::V1::Profile'
    t.references :like, class_name: 'Api::V1::Like'

    t.timestamps
  end
end
