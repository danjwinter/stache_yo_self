class StacheMeController < ApplicationController

  def show
    user_id = params['user_id']
    response = {
  "response_type": "in_channel",
  "text": "ymbed by :troll:\n:rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake::rake:"
}
render json: response
  end
end
