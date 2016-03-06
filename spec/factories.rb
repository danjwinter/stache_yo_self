FactoryGirl.define do
  factory :slack_pic do
    association :user
    face_id '123'
    height 30.078125
    width 30.078125
    mouth_left_x 47.554297
    mouth_left_y 52.6875
    mouth_right_x 59.465039
    mouth_right_y 51.795703
    nose_x 53.956445
    nose_y 44.94668
  end

  factory :user do
  end
end
