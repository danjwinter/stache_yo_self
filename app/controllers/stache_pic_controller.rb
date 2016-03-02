class StachePicController < ApplicationController
  def create
    data = params['canvasImage']
    # current_user.decode_base64_image(data)
    stached_user_image = Paperclip.io_adapters.for(data)
    stached_user_image.original_filename = "something.jpg"
    current_user.stached_user_image = stached_user_image
    current_user.save!
    binding.pry
  end
end
