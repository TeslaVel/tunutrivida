require 'rails_helper'

RSpec.describe "IndicatorTypes", type: :request do
  describe "GET /indicator_types" do
    it "works! (now write some real specs)" do
      get indicator_types_path
      expect(response).to have_http_status(200)
    end
  end
end
