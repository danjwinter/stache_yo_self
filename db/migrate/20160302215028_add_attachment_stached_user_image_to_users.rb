class AddAttachmentStachedUserImageToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :stached_user_image
    end
  end

  def self.down
    remove_attachment :users, :stached_user_image
  end
end
