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


  def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['extra']['user_info']['user']['profile']['real_name']
    user.image_url = auth_hash['extra']['user_info']['user']['profile']['image_1024']
    user.token = auth_hash['credentials']['token']
    user.image = URI.parse(user.image_url)
    user.stache_image = URI.parse("http://i.imgur.com/rJ71NVK.png")
    user.save!
    user.send_for_face_detection
    user
  end

  def self.from_slack(params)
    user = find_or_create_by(uid: params[:user_id])
    user.channel = params["channel_id"]
    user_info = SlackService.new(nil, params[:user_id]).user_info
    user.image_url = user_info['user']['profile']['image_512']
    user.name = user_info['user']['real_name']
    user.image = URI.parse(user.image_url)
    user.save!
    user.send_for_face_detection
    user
  end

  def send_for_face_detection
    fpps = FacePlusPlusService.new(self)
    face_data = fpps.detect_face
    SlackPicCreation.new(self, face_data).create
  end

  def get_that_head_a_stache
    # binding.pry
      pic = slack_pics.last
      slack_pic = Magick::Image.read(image.url).first
      sc = StacheCalculations.new(pic)
      sized_slack_pic = slack_pic.resize_to_fill(400,400)
      stache_pic = Magick::Image.read("#{Rails.root}/app/assets/images/stache_1.png").first
      stache_scale = sc.stache_scale_width_enlarged * 400 * 1.2
      sized_stache = stache_pic.resize_to_fit(stache_scale,stache_scale)
      stached_slack_pic = sized_slack_pic.composite(sized_stache, sc.translate_x, sc.translate_y, Magick::OverCompositeOp)

      processed_image = StringIO.open(stached_slack_pic.to_blob)

      user.stached_user_image = processed_image
      user.save!
  end
end
