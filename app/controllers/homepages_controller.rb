class HomepagesController < InheritedResources::Base
  def show
    @countries = Country.all
  end
end
