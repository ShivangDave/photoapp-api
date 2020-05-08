class CreateApiV1Likes < ActiveRecord::Migration[6.0]
  def change
    create_table :api_v1_likes do |t|
      t.timestamps
    end
  end
end
