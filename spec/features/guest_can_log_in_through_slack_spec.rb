require "rails_helper"

describe "guest can login through slack" do
  it "creates user and associated slack picture"  do
    VCR.use_cassette("slack_login_and_face_detection") do
      visit root_path
      expect(page).to have_content "Stachify"

      click_on "Stachify"

      user = User.last
      slack_pic = user.slack_pics.last

      expect(current_path).to eq(user_path)
      expect(user.name).to eq "Dan Winter"
      expect(user.image_url).to eq "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_1024.jpg"

      expect(slack_pic.face_id).to eq "b7fe4d1710cc81f4baaa41f1bbbf653c"
      expect(slack_pic.height.to_f).to eq 30.5
      expect(slack_pic.width.to_f).to eq 30.5
      expect(slack_pic.mouth_left_x.to_f).to eq 47.079667
      expect(slack_pic.mouth_left_y.to_f).to eq 52.8425
      expect(slack_pic.mouth_right_x.to_f).to eq 58.918833
      expect(slack_pic.mouth_right_y.to_f).to eq 51.746167
      expect(slack_pic.nose_x.to_f).to eq 54.1085
      expect(slack_pic.nose_y.to_f).to eq 44.944
    end
  end
end
