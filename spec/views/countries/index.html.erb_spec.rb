require 'spec_helper'

describe "countries/index.html.erb" do
  before(:each) do
    assign(:countries, [
      stub_model(Country,
        :name => "Name",
        :flag => "Flag"
      ),
      stub_model(Country,
        :name => "Name",
        :flag => "Flag"
      )
    ])
  end

  it "renders a list of countries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Flag".to_s, :count => 2
  end
end
