class StachePicsController < ApplicationController

  def create
    case params[:text]
    when -> (n) { n.start_with?('me') || n.empty? }
      render json: StachePicResponder.send_that_user_a_stache(params)
    when -> (n) { n.start_with?('http', 'www') }
      render json: StachePicResponder.send_that_website_a_stache(params)
    else
      render json: StachePicResponder.send_their_friend_a_stache(params)
    end
  end
end
