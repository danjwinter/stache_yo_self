require "rails_helper"

describe "guest can login through slack" do
  it "sees dashboard with their slack info"  do
    VCR.use_cassette("slack_service#dashboard") do
      visit root_path
      expect(page).to have_content "Stachify"

      click_on "Stachify"

      user = User.last

      expect(current_path).to eq(user_path)
      expect(user.name).to eq "Dan Winter"
      expect(user.image_url).to eq "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_1024.jpg"
    end
  end
end
