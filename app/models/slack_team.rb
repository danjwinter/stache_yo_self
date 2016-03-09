class SlackTeam < ActiveRecord::Base
  has_many :users
  has_many :mustache_requests
end
