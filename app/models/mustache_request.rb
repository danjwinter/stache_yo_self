class MustacheRequest < ActiveRecord::Base
  has_one :user_info
  has_one :face_location

  has_attached_file :stached_user_image,
                    styles: {
                              thumb: '100x100',
                              square: '200x200',
                              medium: '400x400'
                            }
  do_not_validate_attachment_file_type :stached_user_image

  def has_stached_image?
    stached_user_image.url != "/stached_user_images/original/missing.png"
  end
end
