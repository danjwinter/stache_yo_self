class SlackPicCreation
  attr_reader :slack_data, :user

  def initialize(user, slack_data)
    @user = user
    @slack_data = slack_data
  end

  def create
    if slack_data['face'].empty?
      user.update(headless: true)
    else
      user.update(headless: false)
      user.slack_pics.create(
      face_id: slack_data['face'][0]['face_id'],
      height: slack_data['face'][0]['position']['height'],
      width: slack_data['face'][0]['position']['width'],
      mouth_left_x: slack_data['face'][0]['position']['mouth_left']['x'],
      mouth_left_y: slack_data['face'][0]['position']['mouth_left']['y'],
      mouth_right_x: slack_data['face'][0]['position']['mouth_right']['x'],
      mouth_right_y: slack_data['face'][0]['position']['mouth_right']['y'],
      nose_x: slack_data['face'][0]['position']['nose']['x'],
      nose_y: slack_data['face'][0]['position']['nose']['y']
      )
      binding.pry
    end
  end
end
