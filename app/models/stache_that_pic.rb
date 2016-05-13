require 'rmagick'

class StacheThatPic

  def self.create_image(mustache_request)
    create_and_save_stached_pic_to_user(mustache_request)
    MustacheRequestProcessor.process(mustache_request)
  end

  def self.save_original_image(mustache_request)
    url = mustache_request.user_info.image_url
    puts url
    puts "magick pic"
    puts resized(url)
    puts "not stuck in magick pic"
    processed = StringIO.open(resized(mustache_request.user_info.image_url).to_blob)
    puts "created it!"
    mustache_request.original_user_image = processed
    mustache_request.save
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
    user_magick_pic = original_image_magick_pic(mustache_request)
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
    StacheCalculation.new(mustache_request.face_location)
  end

  def self.resized(url)
    Magick::Image.read(url).first.resize_to_fill(400,400)
  end

  def self.resized_original_image_magick(mustache_request)
    original_image_magick_pic(mustache_request).resize_to_fill(400,400)
  end

  def self.original_image_magick_pic(mustache_request)
    Magick::Image.read(mustache_request.original_user_image.url).first
  end
end
