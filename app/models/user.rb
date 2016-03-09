class User < ActiveRecord::Base
  belongs_to :slack_team
end
