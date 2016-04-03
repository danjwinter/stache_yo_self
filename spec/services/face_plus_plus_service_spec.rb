require 'rails_helper'

RSpec.describe FacePlusPlusService do
  before do
    allow(MustacheRequestProcessor).to receive(:process).and_return(nil)
    @mustache_request = create(:mustache_request_with_user_info)
    @fake_image = FakeImage.new
    allow_any_instance_of(MustacheRequest).to receive(:original_user_image) {@fake_image}
  end

  describe ".add_face_location" do
    it "adds coordinates for face location to mustache_request" do
      VCR.use_cassette("TESTface_plus_plus_service#add_face_location") do

        FacePlusPlusService.add_face_location(@mustache_request)

        @mustache_request.reload
        face_location = @mustache_request.face_location
        expect(face_location.mouth_left_x.to_f).to eq 47.554297
        expect(face_location.mouth_left_y.to_f).to eq 52.6875
        expect(face_location.mouth_right_x.to_f).to eq 59.465039
        expect(face_location.mouth_right_y.to_f).to eq 51.795703
        expect(face_location.nose_y.to_f).to eq 44.94668
      end
    end
  end
end
