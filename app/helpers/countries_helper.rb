module CountriesHelper
  def list_countries(countries)
    uls = (1..4).inject([]) {|array, i| array << "<ul class='list-language fleft'>"}
    uls << "<ul class='list-language right-indent-none fleft'>"
    countries.in_groups_of(5, false).each do |group|
      group.each_with_index do |country, index|
        uls[index] += content_tag(:li,
                                  link_to(country.name, page_path(country),
                                          :style => "background: url(#{country.flag.url}) 0 6px no-repeat;"))
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

  def top_countries(countries)
    lis = []
    countries.each_with_index do |c, i|
      index = i + 1
      cl = index <= 3 ? "bg#{index}" : ""
      lis << content_tag(:li, content_tag(:span, index, :class => cl) +
                                link_to(c.name, page_path(c),
                                        :style => "background: url(#{c.flag.url}) 0 6px no-repeat;")).html_safe
    end
    content_tag(:ul, lis.join.html_safe, :class => 'list-top-10').html_safe
  end
end
