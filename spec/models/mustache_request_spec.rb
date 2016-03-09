require 'rails_helper'

RSpec.describe MustacheRequest, type: :model do
  it { should have_one :face_location }
  it { should have_one :user_info }
  it { should respond_to :uid }
  it { should respond_to :channel }
  it { should respond_to :headless }
  it { should have_attached_file :stached_user_image }
  it { should have_attached_file :original_user_image }
end
