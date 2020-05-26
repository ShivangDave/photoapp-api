class CreateApiV1PostComments < ActiveRecord::Migration[6.0]
  def change

    create_table :'api_v1_post_comments' do |t|
      t.references :post, class_name: 'Api::V1::Post'
      t.references :profile, class_name: 'Api::V1::Profile'
      t.references :comment, class_name: 'Api::V1::Comment'

      t.timestamps
    end
  end
end
