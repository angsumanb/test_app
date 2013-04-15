class CreateTestresults < ActiveRecord::Migration
  def change
    create_table :testresults do |t|
      t.string :status
      t.text :comments
      t.integer :testrun_id
      t.integer :testcase_id

      t.timestamps
    end
  end
end
