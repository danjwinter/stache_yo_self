class User < ActiveRecord::Base

  has_many :slack_pics

  has_attached_file :image, styles: {
    thumb: '100x100',
    square: '200x200',
    medium: '400x400'
  }
  validates_attachment :image,
  content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "image/jpg"] }

  has_attached_file :stache_image, styles: {
    thumb: '100x100',
    square: '200x200',
    medium: '400x400'
  }
  validates_attachment :stache_image,
  content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "image/jpg"] }

  has_attached_file :stached_user_image, styles: {
    thumb: '100x100',
    square: '200x200',
    medium: '400x400'
  }
  do_not_validate_attachment_file_type :stached_user_image

  def self.from_slack(params)
    user = find_or_create_by(uid: params[:user_id])
    user.channel = params["channel_id"]
    user_info = SlackService.new(user).user_info
    user.image_url = user_info['user']['profile']['image_512']
    user.name = user_info['user']['real_name']
    user.image = URI.parse(user.image_url)
    user.save!
    user.send_for_face_detection
    user
  end

  private

  def send_for_face_detection
    fpps = FacePlusPlusService.new(self)
    face_data = fpps.detect_face
    SlackPicCreation.new(self, face_data).create
  end
end
