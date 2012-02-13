# -*- encoding : utf-8 -*-
module PagesHelper
  def side_menu_title
    @page.description_type.try(:name) || @page.category.description_type.try(:name)
  end

  def side_bar_for_page(page)
    page.show_menu? ? marked_pages_menu(page) : top_menu(page)
  end

  def marked_pages_menu(page)
    res = []
    res << content_tag(:h3, 'Похожее').html_safe
    res << content_tag(:ul, marked_menu_items(page), :class => 'list2').html_safe
    res.join.html_safe
  end

  def marked_menu_items(page)
    res = []
    Page.where(:show_in_menu => true).each do |p|
      res <<  content_tag(:li, link_to(truncate(p.title, :length => 25), p.url),
                          :class => ('active' if @page == p)).html_safe
    end
    res.join.html_safe
  end

  def top_menu(page)
    res = []
    res << content_tag(:h3, content_tag(:strong, 'Топ').html_safe + content_tag(:span, side_menu_title).html_safe,
                        :class => 'title-bottom1').html_safe
    res << content_tag(:ul, menu_items_for_page(page), :class => 'list1-top-10').html_safe
    res.join.html_safe
  end

  def menu_items_for_page(page)
    items = []
    search_params = (@page.country? || @page.city?) ?
                      {:category_id => Category.where(:description_type_id => @page.description_type_id).map(&:id),
                        :country_id => @page.country_id} :
                        {:city_id => @page.city_id, :country_id => @page.country_id, :category_id => @page.category_id}
    search_params[:city_id] = @page.city_id if @page.city?
    Page.for_top.where(search_params).order('RAND()').limit(10).each_with_index do |p, index|
      items << content_tag(:li, content_tag(:span, index.succ, :class => "bg#{index.succ}") +
                                  link_to(truncate(p.title, :length => 25), p.url),
                                :class => ('active' if @page == p)).html_safe
    end
    items.join.html_safe
  end

  def breadcrumbs
    items = []
    items << link_to(@country.name, page_path(@country)) if @country
    items << link_to(@city.name, page_path(@country, @city)) if @city
    if @page.category?
      items << link_to(@category.name, page_path(@country, @city, @category)) if @category
    end
    items << link_to(@page.title, @page.url) if @page
    items.compact!
    items.last.gsub!('<a', '<span').gsub!('</a', '</span') if items.last
    content_tag(:div, items.join('<span>&nbsp;/&nbsp;</span>').html_safe, :class => 'clear breadcrumbs').html_safe
  end
end
