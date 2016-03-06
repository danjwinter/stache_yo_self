require 'rails_helper'

describe StachePicsController do
  describe "POST #create", type: :controller do
    # before { allow(StacheMeController).to receive(:params) { simulated_slack_slash_stache_me}}
    it "returns the information about an item in json" do

      post :create, simulated_slack_slash_stache_me
      expect(json_response[:response_type]).to eq "in_channel"
      expect(json_response[:text]).to eq "So you want a mustache, eh?"
      # binding.pry
      # StacheMeController.any_instance.stub(params)

      # item_response = json_response
      # expect(item_response[:name]).to eq @item.name
      # expect(item_response[:description]).to eq @item.description
      # expect(item_response[:unit_price]).to eq @item.unit_price.to_s
      # expect(response.status).to eq 200
    end
  end
end
