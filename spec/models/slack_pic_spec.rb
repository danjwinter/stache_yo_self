require 'rails_helper'

RSpec.describe SlackPic, type: :model do
  it { should belong_to(:user)}
  it { should respond_to(:face_id)}
  it { should respond_to(:height)}
  it { should respond_to(:width)}
  it { should respond_to(:mouth_left_x)}
  it { should respond_to(:mouth_left_y)}
  it { should respond_to(:mouth_right_x)}
  it { should respond_to(:mouth_right_y)}
  it { should respond_to(:nose_x)}
  it { should respond_to(:nose_y)}
end
