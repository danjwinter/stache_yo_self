require 'rails_helper'

RSpec.describe SlackTeam, type: :model do
  it { should have_many :mustache_requests }
  it { should have_many :users }
  it { should respond_to :team_id }
  it { should respond_to :team_name }
  it { should respond_to :access_token }

  describe ".configure" do
    it "finds or creates team and saves users for that team" do
      allow(SlackTeam).to receive(:parse).and_return(stubbed_slack_omniauth_response)

      SlackTeam.configure("fake_code")

      expect(SlackTeam.count).to eq 1
      expect(User.count).to_not eq 0
    end
  end
end
