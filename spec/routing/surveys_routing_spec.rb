require "rails_helper"

RSpec.describe SurveysController, type: :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/surveys/1").to route_to("surveys#show", id: "1")
    end
    
  end
end
