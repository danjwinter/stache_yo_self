require 'rails_helper'

describe SlackAppsController do
  describe "GET #create", type: :controller do
    it "creates team in the database, adds user info and redirects to github" do
      # VCR.use_cassette("slack_apps#create") do
      ## commenting out VCR due to compatability issues with Typhoeus

        allow(SlackTeam).to receive(:parse).and_return(stubbed_slack_omniauth_response)

        get :create, code: ENV['SLACK_TEAM_CODE']

        expect(SlackTeam.count).to eq 1
        expect(User.count).to_not eq 0
        expect(response).to redirect_to "http://github.com/danjwinter/stache_yo_self"
        # end
    end
  end
end
