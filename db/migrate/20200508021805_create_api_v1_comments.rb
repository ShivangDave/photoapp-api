class CreateApiV1Comments < ActiveRecord::Migration[6.0]
  def change
    create_table :api_v1_comments do |t|
      t.text :body

      t.timestamps
    end
  end
end
