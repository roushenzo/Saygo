# -*- encoding : utf-8 -*-
module ApplicationHelper
  def meta_tags(options = {})
    params = {
      :title => @page.try(:meta_title).present? ? @page.meta_title : 'Saygo',
      :keywords => @page.try(:meta_keys).present? ? @page.meta_keys : 'Туристический портал, достопримечательности стран, достопримечательности европы, достопримечательности азии, путешествия',
      :description => @page.try(:meta_description).present? ? @page.meta_description : 'Портал о путешествиях и отдыхе, достопримечательности стран, рестораны, магазины, клубы, развлечения, пляжи, острова, интересные факты о странах и городах'
    }.merge(options)
    %Q{
      <title>#{params[:title]}</title>
      <meta name='keywords' content='#{params[:keywords]}' />
      <meta name='description' content='#{params[:description]}' />
    }.html_safe
  end
end
