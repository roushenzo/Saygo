module CitiesHelper
  def list_cities(cities)
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
