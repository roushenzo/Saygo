module ApplicationHelper
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
end

#
# <h3><%= side_menu_title(@page) %></h3>
# <ul class="list2">
#     <li class="active"><a href="#">Общие сведения о Тайланде</a></li>
#     <li><a href="#">Культура</a></li>
#     <li><a href="#">Национальная кухня</a></li>
#     <li><a href="#">Транспорт</a></li>
# </ul>