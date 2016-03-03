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

  def send_for_face_detection
    fpps = FacePlusPlusService.new(self)
    face_data = fpps.detect_face
    SlackPicCreation.new(self, face_data).create
    binding.pry
  end

  def decode_base64_image(image_data)
      # if image_data && content_type && original_filename
      # binding.pry
        decoded_data = Base64.decode64(image_data)
        data = StringIO.new(decoded_data)
        data.class_eval do
          attr_accessor :content_type, :original_filename
        end

        # data.content_type = content_type
        # data.original_filename = File.basename(original_filename)
        data.content_type = "image/jpg"
        data.original_filename = File.basename("stached_image.jpg")

        self.stached_user_image = data
      end
    # end
end
