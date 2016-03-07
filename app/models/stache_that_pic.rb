require 'open-uri'
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
    # file = File.open('dan.jpg', 'wb') do |fo|
    #   fo.write open(pic).read
    # end
    # binding.pry
    puts uri_pic = URI.parse(pic)

    # tempfile = Net::HTTP.start(uri_pic.host, uri_pic.port) do |http|
    #   resp = http.get(uri_pic.path)
    #   file = Tempfile.new('foo', Dir.tmpdir, 'wb+')
    #   file.binmode
    #   file.write(resp.body)
    #   file.flush
    #   file
    # end
 #    signature = Paperclip.io_adapters.for(image)
 # base_name = File.basename(image_name,File.extname(image_name))
 # signature.original_filename = "#{base_name}.jpg"
 # media_img = Media::Image.new()
 # media_img.image = signature
 # media_img.company_id = current_company_id
 # media_img.type = cat
 # media_img.save
    # binding.pry
    puts mustache_request.original_user_image = uri_pic
    puts mustache_request.save
    puts "after original image save"
    magick_pic = Magick::Image.read(mustache_request.original_user_image.url).first
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
