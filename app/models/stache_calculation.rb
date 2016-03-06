class StacheCalculation
  attr_reader :slack_pic

  def initialize(slack_pic)
    @slack_pic = slack_pic
  end

  def translate_x
    mouth_xs_avg - (stache_scale_width_enlarged / 2)
  end

  def translate_y
    (mouth_ys_and_nose_y_avg * 4).to_f
  end

  def stache_scale_width_enlarged
    (stache_scale_width * 1.3 * 400 * 1.2).to_f
  end

  private

  def stache_scale_width
    (slack_pic.mouth_right_x - slack_pic.mouth_left_x) / 100
  end

  def mouth_ys_and_nose_y_avg
    mouth_avg = (slack_pic.mouth_left_y + slack_pic.mouth_right_y) / 2
    mouth_and_nose_y_avg = (mouth_avg + slack_pic.nose_y) / 2
    (mouth_and_nose_y_avg + slack_pic.nose_y * 2) / 3
  end

  def mouth_xs_avg
    (slack_pic.mouth_left_x * 4 + slack_pic.mouth_right_x * 4) / 2
  end
end
