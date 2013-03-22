class CreateTestcases < ActiveRecord::Migration
  def change
    create_table :testcases do |t|
      t.string :title
      t.string :type
      t.string :priority
      t.text :preconditions
      t.string :estimate
      t.text :steps
      t.text :comments
      t.text :expectedresult
      t.integer :suite_id

      t.timestamps
    end
  end
end
