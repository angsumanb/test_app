class AddAttachmentZipToTestcases < ActiveRecord::Migration
  def self.up
    change_table :testcases do |t|
      t.attachment :zip
    end
  end

  def self.down
    drop_attached_file :testcases, :zip
  end
end
