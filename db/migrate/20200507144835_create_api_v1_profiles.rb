class CreateApiV1Profiles < ActiveRecord::Migration[6.0]
  def change
  
    remove_column :api_v1_users, :_id, :text
    remove_column :api_v1_users, :profile_name, :string
    remove_column :api_v1_users, :location, :string
    remove_column :api_v1_users, :slug, :string

    create_table :api_v1_profiles do |t|

      t.text :_id
      t.string :profile_name
      t.string :location
      t.string :slug, :uniq => true
      t.references :user, class_name: 'Api::V1::User'

      t.timestamps
    end
  end
end
