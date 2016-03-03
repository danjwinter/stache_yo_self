class HomeController < ApplicationController
  def homepage
  end

  def privacy
  end

  def show
    @pic = current_user.slack_pics.last
    sc = StacheCalculations.new(@pic)
    # binding.pry
    gon.translate_x = sc.translate_x
    gon.translate_y = sc.translate_y
    gon.inner_scale_width = sc.stache_scale_width_enlarged
  end
end
