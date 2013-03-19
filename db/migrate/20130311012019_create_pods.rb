class CreatePods < ActiveRecord::Migration
  def change
    create_table :pods do |t|
      t.string :name
      t.string :description
      t.integer :project_id

      t.timestamps
    end
  end
end
