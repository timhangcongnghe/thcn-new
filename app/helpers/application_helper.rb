module ApplicationHelper
  def title(title)
    content_for :title, title.to_s
  end
  
  def root_link
    root_path
  end
  
  def category_list_link
    category_list_path
  end
  
  def product_link
    product_path
  end
  
  def product_search_link
    product_search_path
  end
  
  def cart_link
    cart_path
  end
  
  def checkout_link
    checkout_path
  end
  
  def image_set_tag(source, srcset = {}, options = {})
    srcset = srcset.map { |src, size| "#{path_to_image(src)} #{size}" }.join(', ')
    image_tag(source, options.merge(srcset: srcset))
  end
  
  def format_price(price)
    price = (price.to_f/1000).round*1000
    "<span style=\'font-family:sans-serif;\'>#{number_to_currency(price, precision: 0, format: "%n₫", separator: ',', unit: '', delimiter: ".")}</span>".html_safe
  end
end