class StachePicsController < ApplicationController

  def create
    if params[:text].empty? || params[:text].downcase == "me"
      render json: StachePicResponder.send_that_user_a_stache(params)
    else
      render json: StachePicResponder.send_their_friend_a_stache(params)
    end
  end
end
