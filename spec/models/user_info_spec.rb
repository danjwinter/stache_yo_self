require 'rails_helper'

RSpec.describe UserInfo, type: :model do
  it { should belong_to :mustache_request }
  it { should respond_to :image_url }
  it { should respond_to :user_full_name }
end
