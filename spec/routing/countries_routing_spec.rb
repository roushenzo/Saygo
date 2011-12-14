require "spec_helper"

describe CountriesController do
  describe "routing" do

    it "routes to #show" do
      get("/rossia").should route_to("pages#show", :country_id => "rossia")
      get("/rossia/moskva").should route_to("pages#show", :country_id => "rossia", :city_id => 'moskva')
      get("/rossia/moskva/test").should route_to("pages#show", :country_id => "rossia", :city_id => 'moskva', :category_id => 'test')
      get("/rossia/moskva/test/page").should route_to("pages#show", :country_id => "rossia", :city_id => 'moskva', :category_id => 'test', :id => 'page')
    end
  end
end
