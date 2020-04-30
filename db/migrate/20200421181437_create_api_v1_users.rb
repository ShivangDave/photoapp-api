class CreateApiV1Users < ActiveRecord::Migration[6.0]
  def change
    create_table :api_v1_users do |t|
      t.text :_id
      t.string :username
      t.string :password_digest
      t.string :profile_name
      t.string :email
      t.string :location
      t.string :slug, :uniq => true
      
      t.timestamps
    end
  end
end
