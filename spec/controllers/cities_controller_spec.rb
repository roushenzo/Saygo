require 'spec_helper'

describe CitiesController do
  before(:each) {
    @country = Fabricate :country
    @city = City.create :name => 'City', :country => @country
  }
  it {
    get 'index', :country_id => @country.slug
    response.should be_success
  }
  it {
    get 'index', :country_id => @country.id
    response.should be_success
  }
end
