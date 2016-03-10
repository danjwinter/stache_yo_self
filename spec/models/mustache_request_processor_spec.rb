require 'rails_helper'

RSpec.describe MustacheRequestProcessor do
  describe ".process with no user info" do
    it "adds user info" do
    mustache_request = create(:mustache_request)
    allow(FacePlusPlusService).to receive(:add_face_location).and_return(nil)

    MustacheRequestProcessor.process(mustache_request)

    mustache_request.reload

    expect(mustache_request.user_info).to_not eq nil
    end
  end

  describe ".process with user info and no face location" do
    it "adds face location information" do
      mustache_request = create(:mustache_request_with_user_info)
      allow(StacheThatPic).to receive(:create_image).and_return(nil)

      MustacheRequestProcessor.process(mustache_request)

      mustache_request.reload

      expect(mustache_request.face_location).to_not eq nil

    end
  end

  describe ".process with headless" do
    it "sends faceless response and doesn't add mustached image" do
      mustache_request = create(:mustache_request_with_user_and_face_data,
                                headless: true)
      allow(StacheThatPic).to receive(:create_image).and_return(nil)

      resp = MustacheRequestProcessor.process(mustache_request)

      mustache_request.reload

      expect(mustache_request.stached_user_image.url).to eq "/stached_user_images/original/missing.png"
    end
  end

  describe ".process with face data" do
    it "sends faceless response and doesn't add mustached image" do
      mustache_request = create(:mustache_request_with_user_and_face_data,
                                headless: true)
      allow(StacheThatPic).to receive(:create_image).and_return(nil)

      resp = MustacheRequestProcessor.process(mustache_request)
      json_response = JSON.parse(resp.option[:response_body, symbolize_names: true])
      mustache_request.reload

      expect(mustache_request.stached_user_image.url).to eq "/stached_user_images/original/missing.png"
      expect(json_response[:message][:text]).to eq "Life's rough being headless."
      expect(json_response[:message][:attachment][:image_url]).to eq "http://i.imgur.com/9GhYZ9J.png"
    end
  end
end
