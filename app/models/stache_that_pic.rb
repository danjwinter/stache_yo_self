class StacheThatPic

  def self.add_stache_to(user)
    pic = user.slack_pics.last
    slack_pic = Magick::Image.read(user.image.url).first
    sc = StacheCalculations.new(pic)
    sized_slack_pic = slack_pic.resize_to_fill(400,400)
    stache_pic = Magick::Image.read("#{Rails.root}/app/assets/images/stache_1.png").first
    stache_scale = sc.stache_scale_width_enlarged
    sized_stache = stache_pic.resize_to_fit(stache_scale,stache_scale)
    stached_slack_pic = sized_slack_pic.composite(sized_stache, sc.translate_x, sc.translate_y, Magick::OverCompositeOp)

    processed_image = StringIO.open(stached_slack_pic.to_blob)

    user.stached_user_image = processed_image
    user.save!
  end
end
