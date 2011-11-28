require 'spec_helper'

describe Page do
  it { Fabricate.build(:page).should be_valid }
end
