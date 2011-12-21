module PagesHelper
  def side_menu_title
    @city.try(:name) || @country.try(:name)
  end

  def side_bar_for_page(page)
    res = []
    res << content_tag(:h3, side_menu_title).html_safe
    res << content_tag(:ul, menu_items_for_page(page), :class => 'list2').html_safe
    res.join.html_safe
  end

  def menu_items_for_page(page)
    items = []
    cs = (page.city && page.city.categories) || []
    cs.each do |item|
      items << content_tag(:li, link_to(item.name, page_path(@country, @city, item)),
                           :class => ('active' if (@category == item))).html_safe
    end
    items.join.html_safe
  end

  def breadcrumbs
    items = []
    items << link_to(@country.name, page_path(@country)) if @country
    items << link_to(@city.name, page_path(@country, @city)) if @city
    items << link_to(@category.name, page_path(@country, @city, @category)) if @category
    items << link_to(@description_type.name,
      page_path(@country, @city, @category, :description_type_id => @description_type.slug)) if @description_type
    items << link_to(@page.title, @page.url) if @page
    items.compact!
    items.last.gsub!('<a', '<span').gsub!('</a', '</span') if items.last
    content_tag(:div, items.join('<span>&nbsp;/&nbsp;</span>').html_safe, :class => 'clear').html_safe
  end
end
