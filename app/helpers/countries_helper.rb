module CountriesHelper
  def list_countries(countries)
    uls = (1..4).inject([]) {|array, i| array << "<ul class='list-language fleft'>"}
    uls << "<ul class='list-language right-indent-none fleft'>"
    countries.in_groups_of(5, false).each do |group|
      group.each_with_index do |country, index|
        uls[index] += content_tag(:li, link_to(country.name, country, :style => "background: url(#{country.flag.url}) 0 6px no-repeat;"))
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
