class AddQidToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :qid, :integer
  end
end
