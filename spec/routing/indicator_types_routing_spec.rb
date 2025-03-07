require "rails_helper"

RSpec.describe IndicatorTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/indicator_types").to route_to("indicator_types#index")
    end

    it "routes to #new" do
      expect(:get => "/indicator_types/new").to route_to("indicator_types#new")
    end

    it "routes to #show" do
      expect(:get => "/indicator_types/1").to route_to("indicator_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/indicator_types/1/edit").to route_to("indicator_types#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/indicator_types").to route_to("indicator_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/indicator_types/1").to route_to("indicator_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/indicator_types/1").to route_to("indicator_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/indicator_types/1").to route_to("indicator_types#destroy", :id => "1")
    end
  end
end
