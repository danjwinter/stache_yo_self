require 'rails_helper'

describe StachePicsController do
  describe "POST #create", type: :controller do
    it "returns the information about an item in json" do

      post :create, simulated_slack_slash_stache_me, text: 'me'
      expect(json_response[:response_type]).to eq "in_channel"
      expect(json_response[:text]).to eq "So you want a mustache, eh?"
    end
  end
end
