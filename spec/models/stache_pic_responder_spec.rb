require 'rails_helper'

RSpec.describe StachePicResponder do
  describe ".send_that_user_a_stache" do
    it "returns correct response" do
      # allow(MustacheRequestProcessor).to receive(:process).and_return(nil)
      allow(StachePicResponder).to receive(:mustache_request).and_return(nil)
      allow(StachePicResponder).to receive(:start_mustacheing).and_return(nil)
      params = {text: "me"}
      expected_response = {:response_type=>"in_channel",
                           :text=>"So you want a mustache, eh?"}

      response = StachePicResponder.send_that_user_a_stache(params)
      expect(response).to eq expected_response
      expect(StachePicResponder).to have_received(:mustache_request)
      expect(StachePicResponder).to have_received(:start_mustacheing)
    end
  end

  describe ".send_their_friend_a_stache" do
    it "returns correct response when user is found" do

      allow(StachePicResponder).to receive(:start_mustacheing).and_return(nil)
      allow(StachePicResponder).to receive(:mustache_request).and_return(nil)
      user = User.create(screen_name: "gob", uid: "9420954", first_name: "George")
      params = {text: "@gob"}

      expected_response = {:response_type=>"in_channel",
                           :text=>"So you want to stache George, eh?"}

      response = StachePicResponder.send_their_friend_a_stache(params)

      expect(response).to eq expected_response
      expect(StachePicResponder).to have_received(:mustache_request)
      expect(StachePicResponder).to have_received(:start_mustacheing)
    end

    it "returns correct response when user is not found" do
      allow(StachePicResponder).to receive(:start_mustacheing).and_return(nil)
      allow(StachePicResponder).to receive(:mustache_request).and_return(nil)
      allow(MustacheRequestProcessor).to receive(:process).and_return(nil)
      params = {text: "@gob"}
      expected_response = {:response_type=>"in_channel",
                           :text=>"That's not a person! Why don't you just go Stache Yo Self!"}

      response = StachePicResponder.send_their_friend_a_stache(params)

      expect(response).to eq expected_response
      expect(StachePicResponder).to have_received(:mustache_request)
      expect(StachePicResponder).to have_received(:start_mustacheing)
    end
  end
end
