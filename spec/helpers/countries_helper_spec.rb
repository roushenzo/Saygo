require 'spec_helper'

describe CountriesHelper do
  before(:each) {
    10.times {Fabricate(:country)}
  }

  it {
    helper.list_countries(Country.all).should be_present
  }

  it {
    helper.top_countries(Country.all).should be_present
  }
end
