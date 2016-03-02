class AddAttachmentStacheImageToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :stache_image
    end
  end

  def self.down
    remove_attachment :users, :stache_image
  end
end
