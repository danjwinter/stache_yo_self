require 'rails_helper'

RSpec.describe StacheCalculation do
  before do
    mustache_request = create(:mustache_request, face_location: create(:face_location))
    @sc = StacheCalculation.new(mustache_request)
  end

  it "returns correct translation of x axis for stache" do
    expect(@sc.translate_x.to_f).to eq 176.87715696
  end

  it "returns correct translation of y axis for stache" do
    expect(@sc.translate_y.to_f).to eq 184.650001
  end

  it "returns correct scaling width for stache" do
    expect(@sc.stache_scale_width_enlarged.to_f).to eq 74.32303008
  end

end
