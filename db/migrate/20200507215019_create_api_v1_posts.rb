class CreateApiV1Posts < ActiveRecord::Migration[6.0]
  def change
    create_table :api_v1_posts do |t|
      t.text :caption
      t.string :location
      t.references :profile, class_name: 'Api::V1::Profile'

      t.timestamps
    end
  end
end
