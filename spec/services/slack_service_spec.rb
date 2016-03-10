require 'rails_helper'

RSpec.describe SlackService do
  before do
    @mustache_request = create(:mustache_request)
  end

  describe ".add_user_info" do
    it "adds user information to mustache_request" do
      # VCR.use_cassette("slack_service#add_user_info") do
      # Commenting out VCR due to compatability issues with Typhoeus
      # Message Posting to be tested at a later date due to unavailability of test domain

        allow(MustacheRequestProcessor).to receive(:process).and_return(nil)

        # Stubbing json response because VCR stubs Typhoeus to return different
        # has values than when hitting actual API
        allow(SlackService).to receive(:parse).and_return(stubbed_slack_user_info_json_response)

        expect(@mustache_request.user_info).to eq nil

        SlackService.add_user_info(@mustache_request)

        user_info = @mustache_request.user_info

        expect(user_info).to_not eq nil
        expect(user_info.image_url).to eq "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_512.jpg"
        expect(user_info.user_full_name).to eq "Dan Winter"
      # end
    end
  end
end
