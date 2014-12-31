require 'rails_helper'

RSpec.describe "Prototypes", :type => :request do
  describe "GET /prototypes" do
    it "works! (now write some real specs)" do
      get prototypes_path
      expect(response).to have_http_status(200)
    end
  end
end
