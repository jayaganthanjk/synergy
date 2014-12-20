require 'rails_helper'

RSpec.describe "Timelogs", :type => :request do
  describe "GET /timelogs" do
    it "works! (now write some real specs)" do
      get timelogs_path
      expect(response.status).to be(200)
    end
  end
end
