class ProductImage < ActiveRecord::Base
  self.table_name = 'erp_products_product_images'
  belongs_to :product
  mount_uploader :image_url, ProductImageUploader
  default_scope {order(id: :desc)}
  
  def image_path(version = nil)
    if self.image_url.nil?
      return ''
    elsif !version.nil?
      return self.image_url(version)
    else
      return self.image_url
    end
  end
  
  def image(version = nil)
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.url_for(controller: 'product_images', action: 'image', title: self.product.alias, id: self.id, thumb: version)
  end
end