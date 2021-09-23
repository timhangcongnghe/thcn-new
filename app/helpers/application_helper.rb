module ApplicationHelper
  def title(title)
    content_for :title, title.to_s
  end
  
  def root_link
    root_path
  end
  
  def category_link
    category_path
  end

  def category_list_link(category)
    category_list_path(category_id: category.id, category_alias: category.alias)
  end
  
  def product_link(product)
    product_path(product_id: product.id, product_alias: product.alias)
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
  
  def finish_link
    checkout_path
  end
  
  def track_link
    track_path
  end
  
  def about_link
    about_path
  end
  
  def contact_link
    contact_path
  end
  
  # START Brand
  def brand_list_link
    brand_list_path
  end
  
  def brand_detail_link
    brand_detail_path
  end
  # END Brand
  
  # START Account
  def account_login_link
    account_login_path
  end
  
  def account_register_link
    account_register_path
  end
  # END Account
  
  # START Guide
  def shopping_guide_link
    shopping_guide_path
  end
  # END Guide
  
  # START 404
  def error_404_link
    error_404_path
  end
  # END 404
  
  def image_set_tag(source, srcset = {}, options = {})
    srcset = srcset.map { |src, size| "#{path_to_image(src)} #{size}" }.join(', ')
    image_tag(source, options.merge(srcset: srcset))
  end
  
  def format_price(price)
    price = (price.to_f/1000).round*1000
    "<span style=\'font-family:sans-serif;\'>#{number_to_currency(price, precision: 0, format: "%n₫", separator: ',', unit: '', delimiter: ".")}</span>".html_safe
  end
end