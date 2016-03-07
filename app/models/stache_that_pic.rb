class StacheThatPic

  def self.add_stache_to(user)
    pic = user.slack_pics.last
    slack_pic = Magick::Image.read(user.image.url).first
    sc = StacheCalculation.new(pic)
    sized_slack_pic = slack_pic.resize_to_fill(400,400)
    stache_pic = Magick::Image.read("#{Rails.root}/app/assets/images/stache_1.png").first
    stache_scale = sc.stache_scale_width_enlarged
    sized_stache = stache_pic.resize_to_fit(stache_scale,stache_scale)
    stached_slack_pic = sized_slack_pic.composite(sized_stache, sc.translate_x, sc.translate_y, Magick::OverCompositeOp)

    processed_image = StringIO.open(stached_slack_pic.to_blob)

    user.stached_user_image = processed_image
    user.save!
  end

  def self.create_image(mustache_request)
    pic = mustache_request.user_info.image_url
    magick_pic = Magick::Image.read(pic).first
    sc = StacheCalculation.new(mustache_request.face_location)
    sized_magick_pic = magick_pic.resize_to_fill(400,400)
    stache_pic = Magick::Image.read("#{Rails.root}/app/assets/images/stache_1.png").first
    stache_scale = sc.stache_scale_width_enlarged
    sized_stache = stache_pic.resize_to_fit(stache_scale,stache_scale)
    stached_slack_pic = sized_magick_pic.composite(sized_stache, sc.translate_x, sc.translate_y, Magick::OverCompositeOp)

    processed_image = StringIO.open(stached_slack_pic.to_blob)

    mustache_request.stached_user_image = processed_image
    mustache_request.save!
    MustacheRequestProcessor.process(mustache_request)
  end
end
