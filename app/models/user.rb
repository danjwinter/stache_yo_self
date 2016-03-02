class User < ActiveRecord::Base
  has_many :slack_pics

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['extra']['user_info']['user']['profile']['real_name']
    user.image_url = auth_hash['extra']['user_info']['user']['profile']['image_1024']
    user.token = auth_hash['credentials']['token']
    user.save!
    user.send_for_face_detection
    user
  end

  def send_for_face_detection
    fpps = FacePlusPlusService.new(self)
    face_data = fpps.detect_face
    SlackPicCreation.new(self, face_data).create
  end
end
