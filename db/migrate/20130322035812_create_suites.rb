class CreateSuites < ActiveRecord::Migration
  def change
    create_table :suites do |t|
      t.string :name
      t.string :description
      t.integer :pod_id

      t.timestamps
    end
  end
end
