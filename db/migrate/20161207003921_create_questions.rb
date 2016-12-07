class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.text :details
      t.string :input_type
      t.string :options

      t.timestamps null: false
    end
  end
end
