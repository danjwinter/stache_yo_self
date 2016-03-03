class StachePicController < ApplicationController
  def create
    data = params['canvasImage']
    stached_user_image = Paperclip.io_adapters.for(data)
    stached_user_image.original_filename = "stached_slack.jpg"
    current_user.stached_user_image = stached_user_image
    current_user.save!
  end
end
