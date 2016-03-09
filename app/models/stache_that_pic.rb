class StacheThatPic

  def self.create_image(mustache_request)
    grab_image_from_url_and_save_to_user(mustache_request)
    create_and_save_stached_pic_to_user(mustache_request)
    MustacheRequestProcessor.process(mustache_request)
  end

  private

  def self.create_and_save_stached_pic_to_user(mustache_request)
    stached_pic = stached_user_magick_pic(mustache_request)
    processed_image = StringIO.open(stached_pic.to_blob)
    mustache_request.stached_user_image = processed_image
    mustache_request.save
  end

  def self.stached_user_magick_pic(mustache_request)
    user_magick_pic = resized_original_image_magick(mustache_request)
    stache_magick_pic = resized_stache_magick_pic(mustache_request)
    stache_calcs = stache_calculations(mustache_request)
    user_magick_pic.composite(stache_magick_pic,
                                            stache_calcs.translate_x,
                                            stache_calcs.translate_y,
                                            Magick::OverCompositeOp)
  end

  def self.resized_stache_magick_pic(mustache_request)
    stache_scale = stache_calculations(mustache_request).stache_scale_width_enlarged
    stache_magick_pic.resize_to_fit(stache_scale,stache_scale)
  end

  def self.stache_magick_pic
    Magick::Image.read("#{Rails.root}/app/assets/images/stache_1.png").first
  end

  def self.stache_calculations(mustache_request)
    @sc ||= StacheCalculation.new(mustache_request.face_location)
  end

  def self.resized_original_image_magick(mustache_request)
    original_image_magick_pic(mustache_request).resize_to_fill(400,400)
  end

  def self.original_image_magick_pic(mustache_request)
    Magick::Image.read(mustache_request.original_user_image.url).first
  end

  def self.grab_image_from_url_and_save_to_user(mustache_request)
    pic = URI.parse(mustache_request.user_info.image_url)
    mustache_request.original_user_image = pic
    mustache_request.save
  end
end
