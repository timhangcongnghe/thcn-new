class ProductImage < ApplicationRecord
  self.table_name = 'erp_products_product_images'
  belongs_to :product
  mount_uploader :image_url, ProductImageUploader
  
  def image_path(version = nil)
    if self.image_url_url.nil?
      return '/img/tmp_products/laptop-dell-latitude-3320.jpg'
    elsif !version.nil?
      return self.image_url_url(version)
    else
      return self.image_url_url
    end
  end
  
  def image(version = nil)
    return '/img/tmp_products/laptop-dell-latitude-3320.jpg' if id.nil?
    
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.url_for(controller: 'product_images', action: 'image', title: self.product.alias, id: self.id, thumb: version)
  end
end