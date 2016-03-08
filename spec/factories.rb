FactoryGirl.define do
  factory :mustache_request do
    uid "03424"
    channel "U2940234"
    headless false
  end

  factory :face_location do
    mustache_request nil
    mouth_left_x 47.554297
    mouth_left_y 52.6875
    mouth_right_x 59.465039
    mouth_right_y 51.795703
    nose_y 44.94668
  end
end
