class FacePlusPlusService
  attr_reader :connection, :user

  def initialize(user)
    @connection ||= Faraday.new(url: "http://apius.faceplusplus.com/") do |faraday|
      faraday.request :url_encoded
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
    @user = user
  end

  def detect_face
    parse(connection.get("detection/detect", mode: "oneface", api_key: ENV['FACE_KEY'], api_secret: ENV['FACE_SECRET'], url: user.image_url))
  end


  private

  def parse(response)
    JSON.parse(response.body, symbolize_name: true)
  end

  def include_tokens
    {api_key: ENV['FACE_KEY'], api_secret: ENV['FACE_SECRET']}
  end
end
