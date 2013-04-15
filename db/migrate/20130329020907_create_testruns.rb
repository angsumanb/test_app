class CreateTestruns < ActiveRecord::Migration
  def change
    create_table :testruns do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
