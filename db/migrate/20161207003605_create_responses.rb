class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :value
      t.integer :user_id
      t.integer :question_id
      t.integer :survey_id
      t.timestamps null: false
    end
  end
end
