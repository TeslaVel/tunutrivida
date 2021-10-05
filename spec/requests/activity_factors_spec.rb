require 'rails_helper'

RSpec.describe "ActivityFactors", type: :request do
  describe "GET /activity_factors" do
    it "works! (now write some real specs)" do
      get activity_factors_path
      expect(response).to have_http_status(200)
    end
  end
end
