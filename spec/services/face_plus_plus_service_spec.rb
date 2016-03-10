require 'rails_helper'

RSpec.describe FacePlusPlusService do
  before do
    @mustache_request = create(:mustache_request_with_user_info)
  end

  describe ".add_face_location" do
    it "adds coordinates for face location to mustache_request" do
      # VCR.use_cassette("face_plus_plus_service#add_face_location") do
      # Commenting out VCR due to compatability issues with Typhoeus
        allow(MustacheRequestProcessor).to receive(:process).and_return(nil)

        # Stubbing json response because VCR stubs Typhoeus to return different
        # has values than when hitting actual API
        allow(FacePlusPlusService).to receive(:parse).and_return(stubbed_face_plus_plus_json_response)


        FacePlusPlusService.add_face_location(@mustache_request)

        @mustache_request.reload
        face_location = @mustache_request.face_location

        expect(face_location.mouth_left_x.to_f).to eq 47.554297
        expect(face_location.mouth_left_y.to_f).to eq 52.6875
        expect(face_location.mouth_right_x.to_f).to eq 59.465039
        expect(face_location.mouth_right_y.to_f).to eq 51.795703
        expect(face_location.nose_y.to_f).to eq 44.94668
      # end
    end
  end
end
