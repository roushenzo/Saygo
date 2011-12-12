require "spec_helper"

describe CountriesController do
  describe "routing" do

    it "routes to #show" do
      get("/countries/1").should route_to("pages#show", :id => "1")
    end

  end
end
