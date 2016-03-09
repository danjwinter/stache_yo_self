require 'rails_helper'

RSpec.describe StacheThatPic do
  before do
    @mustache_request = create(:mustache_request_with_user_and_face_data)
  end

  it "creates a stached version of the user's profile picture" do
    fake_image = FakeImage.new

    allow(MustacheRequestProcessor).to receive(:process).and_return(nil)
    # if !@mustache_request.original_user_image.nil?
    #   MustacheRequest.any_instance.stub(:original_user_image).and_return(fake_image)
    # end
    StacheThatPic.create_image(@mustache_request)

    @mustache_request.reload
    binding.pry
    expect(@mustache_request.stached_user_image)
  end
end
