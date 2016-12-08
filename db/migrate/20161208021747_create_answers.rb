class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :num_value
      t.string :str_value
      t.boolean :bool_value
      t.integer :question_id
      t.integer :survey_id
      t.integer :response_id
      t.integer :user_id

      t.timestamps null: false
    end

    remove_column :responses, :value
    remove_column :responses, :question_id
  end
end
