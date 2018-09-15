class StachePicsController < ApplicationController

    def check
        render json: { status: 200 }
    end
end