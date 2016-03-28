class MustacheRequest < ActiveRecord::Base
  has_one :user_info
  has_one :face_location
  belongs_to :slack_team

  has_attached_file :stached_user_image,
                    styles: {
                              thumb: '100x100',
                              square: '200x200',
                              medium: '400x400'
                            }
  do_not_validate_attachment_file_type :stached_user_image

  has_attached_file :original_user_image,
                    styles: {
                              thumb: '100x100',
                              square: '200x200',
                              medium: '400x400'
                            }
  do_not_validate_attachment_file_type :original_user_image

  def has_stached_image?
    stached_user_image.url != "/stached_user_images/original/missing.png"
  end

  def has_no_original_image?
    original_user_image.url == "/original_user_images/original/missing.png"
  end
end
