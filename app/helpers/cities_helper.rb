module CitiesHelper
  def list_cities(country)
    country_pages_ids = Page.scoped(:conditions => ["category_id is NULL and city_id is not NULL and active=?", true]).select(:city_id).map(&:city_id).uniq
    cities = country.cities.where(:id => country_pages_ids)
    uls = (1..4).inject([]) {|array, i| array << "<ul class='list-language fleft'>"}
    uls << "<ul class='list-language right-indent-none fleft'>"
    cities.in_groups_of(5, false).each do |group|
      group.each_with_index do |city, index|
        uls[index] += content_tag(:li, link_to(city.name, page_path(city.country, city)))
      end
    end
    uls.each_with_index do |ul, index|
      unless ul =~ /<li>/
        uls[index] = nil
      else
        uls[index] += "</ul>"
      end
    end
    content_tag(:div, uls.compact.join.html_safe, :class => 'row-list-language clear').html_safe
  end
end
