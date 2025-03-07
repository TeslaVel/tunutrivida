require "rails_helper"

RSpec.describe ActivityFactorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/activity_factors").to route_to("activity_factors#index")
    end

    it "routes to #new" do
      expect(:get => "/activity_factors/new").to route_to("activity_factors#new")
    end

    it "routes to #show" do
      expect(:get => "/activity_factors/1").to route_to("activity_factors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/activity_factors/1/edit").to route_to("activity_factors#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/activity_factors").to route_to("activity_factors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/activity_factors/1").to route_to("activity_factors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/activity_factors/1").to route_to("activity_factors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/activity_factors/1").to route_to("activity_factors#destroy", :id => "1")
    end
  end
end
