class AddAttachmentPhotoToTestcases < ActiveRecord::Migration
  def self.up
    change_table :testcases do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :testcases, :photo
  end
end
