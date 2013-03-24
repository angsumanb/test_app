class FixTestcaseColumnName < ActiveRecord::Migration
  def up
    rename_column :testcases, :type, :testtype
  end

  def down
    rename_column :testcases, :testtype, :type
  end
end
