require 'rails_helper'

# This test has been put on hold until a way is found to locate image url from
# Paperclip without sending test images to AWS S3

# RSpec.describe StacheThatPic do
#   before do
#     @mustache_request = create(:mustache_request_with_user_and_face_data)
#   end
#
#   it "creates a stached version of the user's profile picture" do
#     fake_image = FakeImage.new
#
#     allow(MustacheRequestProcessor).to receive(:process).and_return(nil)
#
#     StacheThatPic.create_image(@mustache_request)
#
#     @mustache_request.reload
#
#     expect(@mustache_request.stached_user_image)
#   end
# end
