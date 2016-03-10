FactoryGirl.define do

  factory :slack_team do
    team_id "T029P2S9M"
    team_name "Turing"
    access_token ENV['SAMPLE_SLACK_ACCESS_TOKEN']
  end

  factory :mustache_request do
    uid "U09UB1KCN"
    channel "C0QL1GXS9"
    association :slack_team

    factory :mustache_request_with_user_info do
      association :user_info

      factory :mustache_request_with_user_and_face_data do
        association :face_location
      end
    end
  end

  factory :face_location do
    mouth_left_x 47.554297
    mouth_left_y 52.6875
    mouth_right_x 59.465039
    mouth_right_y 51.795703
    nose_y 44.94668
  end

  factory :user_info do
    image_url "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_512.jpg"
    user_full_name "Gob Bluth"
  end
end
