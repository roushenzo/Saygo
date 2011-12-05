require 'spec_helper'

describe Page do
  it {
    Fabricate(:page).should be_valid
  }

  context 'reset sight of the day' do
    before(:each) {
      @page1, @page2 = Fabricate(:page, :sight_of_the_day => true), Fabricate(:page)
    }
    it {lambda {@page2.update_attribute(:sight_of_the_day, true); @page1.reload}.should change(@page1, :sight_of_the_day?).from(true).to(false)}
    it {lambda {@page2.update_attribute(:sight_of_the_day, true)}.should_not change(Page.where(:sight_of_the_day => true), :count)}
    it {lambda {@page2.update_attribute(:sight_of_the_day, true)}.should change(@page2, :sight_of_the_day?).from(false).to(true)}
    it {
      Page.current_sight_of_the_day.id.should eq(@page1.id)
      @page2.update_attribute(:sight_of_the_day, true)
      Page.current_sight_of_the_day.id.should eq(@page2.id)
    }
  end

  it {
    Page.destroy_all
    page = Fabricate(:page, :sight_of_the_day => false)
    Page.where(:sight_of_the_day => true).should be_blank
    Page.current_sight_of_the_day.id.should eq(page.id)
  }
  it {
    Page.destroy_all
    page = Fabricate(:page, :sight_of_the_day => true)
    10.times {Fabricate(:page, :sight_of_the_day => false)}
    Page.current_sight_of_the_day.should eq(page)
  }
end
