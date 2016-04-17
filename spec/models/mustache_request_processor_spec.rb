require 'rails_helper'

RSpec.describe MustacheRequestProcessor do
  describe ".process with no user info" do
    it "adds user info" do
      VCR.use_cassette("slack_service#save_user_info") do
        mustache_request = create(:mustache_request)
        allow(FacePlusPlusService).to receive(:add_face_location).and_return(nil)

        MustacheRequestProcessor.process(mustache_request)

        mustache_request.reload

        expect(mustache_request.user_info).to_not eq nil
      end
    end
  end

  describe ".process with user info and no face location" do
    it "adds face location information" do
      VCR.use_cassette("face_service#face_location") do
        mustache_request = create(:mustache_request_with_user_info)
        fake_image = FakeImage.new
        allow_any_instance_of(MustacheRequest).to receive(:original_user_image) {fake_image}
        allow(StacheThatPic).to receive(:create_image).and_return(nil)

        MustacheRequestProcessor.process(mustache_request)

        mustache_request.reload

        expect(mustache_request.face_location).to_not eq nil
      end
    end
  end

  describe ".process with headless" do
    it "sends faceless response and doesn't add mustached image" do
      mustache_request = create(:mustache_request_with_user_and_face_data,
                                headless: true)

      allow(SlackService).to receive(:post_headless_response) {nil}

      MustacheRequestProcessor.process(mustache_request)
      mustache_request.reload

      expect(SlackService).to have_received(:post_headless_response)

      expect(mustache_request.stached_user_image.url).to eq "/stached_user_images/original/missing.png"
    end
  end

  describe ".process without original image" do
    it "sends message to save image" do
      mustache_request = create(:mustache_request_with_user_info,
                                original_user_image: nil)

      allow(StacheThatPic).to receive(:save_original_image) {nil}

      MustacheRequestProcessor.process(mustache_request)

      expect(StacheThatPic).to have_received(:save_original_image)
    end
  end

  describe ".process without original image" do
    it "sends message to save image" do
      mustache_request = create(:mustache_request_with_user_info,
                                original_user_image: nil)

      allow(StacheThatPic).to receive(:save_original_image) {nil}

      MustacheRequestProcessor.process(mustache_request)

      expect(StacheThatPic).to have_received(:save_original_image)
    end
  end

  describe ".process with face location" do
    it "sends message to create stached image" do
      mustache_request = create(:mustache_request_with_user_and_face_data)

      allow(StacheThatPic).to receive(:create_image) {nil}

      MustacheRequestProcessor.process(mustache_request)
      # binding.pry

      expect(StacheThatPic).to have_received(:create_image)
    end
  end

  describe ".process with stached image" do
    it "sends message to post stached response" do
      mustache_request = create(:mustache_request_with_user_and_face_data)
      allow(mustache_request).to receive(:has_no_stached_image?) {false}

      allow(SlackService).to receive(:post_stached_image) {nil}

      MustacheRequestProcessor.process(mustache_request)

      expect(SlackService).to have_received(:post_stached_image)
    end
  end
end
