class CreateApiV1Follows < ActiveRecord::Migration[6.0]
  def change
    create_table :api_v1_follows do |t|
      t.integer :followee_id
      t.integer :follower_id
      
      t.timestamps
    end
  end
end
