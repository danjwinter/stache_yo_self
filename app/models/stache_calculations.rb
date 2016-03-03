class StacheCalculations
  attr_reader :slack_pic

  def initialize(slack_pic)
    @slack_pic = slack_pic
  end

  def translate_x
    ((slack_pic.nose_x * 4) - (stache_width * 2.25)).to_f
  end


  def translate_y
    (mouth_ys_and_nose_y_avg * 4).to_f
  end

  def stache_scale_width_enlarged
    (stache_scale_width * 1.3).to_f
  end

  private

  def stache_scale_width
    (slack_pic.mouth_right_x - slack_pic.mouth_left_x) / 100
  end

  def stache_width
    (slack_pic.mouth_right_x - slack_pic.mouth_left_x) * 1.3
  end

  def mouth_ys_and_nose_y_avg
    mouth_avg = (slack_pic.mouth_left_y + slack_pic.mouth_right_y) / 2
    mouth_and_nose_y_avg = (mouth_avg + slack_pic.nose_y) / 2
    (mouth_and_nose_y_avg + slack_pic.nose_y) / 2
  end
end
