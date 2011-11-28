require 'spec_helper'

describe "countries/show.html.erb" do
  before(:each) do
    @country = assign(:country, stub_model(Country,
      :name => "Name",
      :flag => "Flag"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Flag/)
  end
end
