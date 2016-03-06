class SlackPic < ActiveRecord::Base
  belongs_to :user

  def headless?
    headless
  end
end
