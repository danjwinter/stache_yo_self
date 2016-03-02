class User < ActiveRecord::Base

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['extra']['user_info']['user']['profile']['real_name']
    user.image_url = auth_hash['extra']['user_info']['user']['profile']['image_1024']
    user.token = auth_hash['credentials']['token']
    user.save!
    user
  end

  def send_for_face_detection

  end
end
