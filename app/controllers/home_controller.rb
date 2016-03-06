require 'rmagick'
class HomeController < ApplicationController
  def homepage
  end

  def privacy
  end

  def show
    # binding.pry
    @pic = current_user.slack_pics.last
    slack_pic = Magick::Image.read(current_user.image.url).first
    sc = StacheCalculations.new(@pic)
    sized_slack_pic = slack_pic.resize_to_fill(400,400)
    # binding.pry
    stache_pic = Magick::Image.read("#{Rails.root}/app/assets/images/stache_1.png").first
    stache_scale = sc.stache_scale_width_enlarged * 400 * 1.2
    sized_stache = stache_pic.resize_to_fit(stache_scale,stache_scale)
    stached_slack_pic = sized_slack_pic.composite(sized_stache, sc.translate_x, sc.translate_y, Magick::OverCompositeOp)

    processed_image = StringIO.open(stached_slack_pic.to_blob)

    current_user.stached_user_image = processed_image
    current_user.save!

    gon.translate_x = sc.translate_x
    gon.translate_y = sc.translate_y
    gon.inner_scale_width = sc.stache_scale_width_enlarged
  end
end
