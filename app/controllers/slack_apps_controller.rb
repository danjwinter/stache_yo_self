class SlackAppsController < ApplicationController

  def create
    code = params[:code]

    SlackTeam.configure(code)

    redirect_to "http://github.com/danjwinter/stache_yo_self"
  end
end
