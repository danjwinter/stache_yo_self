class HomeController < ApplicationController
  def homepage
  end

  def privacy
  end

  def show
    @pic = current_user.slack_pics.last
  end
end
