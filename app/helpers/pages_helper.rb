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
    is_ds = true
    cs =  if page.country?
      page.country.description_types
    elsif page.city?
      page.city.description_types
    else
      is_ds = false
      page.city.categories
    end
    cs.each do |item|
      params = is_ds ? {:description_type_id => item.slug} : {:category_id => item.slug}
      items << content_tag(:li,
                           link_to(item.name, page_path(@country, @city, params)),
                           :class => ('active' if (is_ds && @description_type == item ) || (!is_ds && @category == item))).html_safe
    end
    items.join.html_safe
  end

  def breadcrumbs
    items = []
    items << link_to_if(@country, @country.name, page_path(@country))
    items << link_to_if(@city, @city.try(:name), page_path(@country, @city))
    items << link_to_if(@category, @category.try(:name), page_path(@country, @city, @category))
    items << link_to_if(@description_type, @description_type.try(:name),
                          page_path(@country, @city, :description_type_id => @description_type.try(:slug)))
    items << link_to_if(@page, @page.title, page_path(@country, @city, @category, :id => @page.try(:slug)))
    items.compact!
    items.last.gsub!('<a', '<span').gsub!('</a', '</span') if items.last
    content_tag(:div, items.join('<span>&nbsp;/&nbsp;</span>').html_safe, :class => 'clear').html_safe
  end
end
