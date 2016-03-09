require 'rails_helper'

RSpec.describe FaceLocation, type: :model do
  it { should belong_to :mustache_request}
  it { should respond_to :mouth_left_x}
  it { should respond_to :mouth_left_y}
  it { should respond_to :mouth_right_x}
  it { should respond_to :mouth_right_y}
  it { should respond_to :nose_y}
end
