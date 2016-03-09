require 'rails_helper'

RSpec.describe StacheCalculation do
  before do
    @mustache_request = create(:mustache_request)
  end

  it "adds user info when it has none" do

    allow(FacePlusPlusService).to receive(:add_face_location).and_return(nil)

    MustacheRequestProcessor.process(@mustache_request)

    @mustache_request.reload

    expect(@mustache_request.user_info).to_not eq nil
  end

end
