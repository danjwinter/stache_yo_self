class AddAttachmentOriginalUserImageToMustacheRequests < ActiveRecord::Migration
  def self.up
    change_table :mustache_requests do |t|
      t.attachment :original_user_image
    end
  end

  def self.down
    remove_attachment :mustache_requests, :original_user_image
  end
end
