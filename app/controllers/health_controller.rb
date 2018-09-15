class HealthController < ApplicationController

    def check
        render json: { status: 200 }
    end
end