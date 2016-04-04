require 'rails_helper'

describe SlackAppsController do
  describe "GET #create", type: :controller do
    it "creates team in the database, adds user info and redirects to github" do
      VCR.use_cassette("slack_apps#create") do

        allow(SlackTeam).to receive(:response).and_return(stubbed_oauth_response)
        allow(SlackService).to receive(:slack_user_list).and_return(stubbed_slack_user_list)

        get :create, code: 12345678

        expect(SlackTeam.count).to eq 1
        expect(User.count).to_not eq 0

        expect(response).to redirect_to "http://github.com/danjwinter/stache_yo_self"
        end
    end
  end
end
