class Product < ActiveRecord::Base
  self.table_name = 'erp_products_products'
  belongs_to :category
  has_many :product_images
  
  # tra ve ket qua gia ban
  def product_price
    return self.price if !self.is_deal
    from_conds = !self.deal_from_date.present? || (self.deal_from_date.present? && Time.now >= self.deal_from_date.beginning_of_day)
    to_conds = !self.deal_to_date.present? || (self.deal_to_date.present? && Time.now <= self.deal_to_date.end_of_day)
    if from_conds && to_conds
      return self.deal_price
    else
      self.update_column(:is_deal, false)
      return self.price
    end
  end
  
  # lay hinh anh chinh
  def get_all_images
    product_images.where.not(image_url: nil).order('id desc')
  end
  
  def get_main_image
		img = get_all_images.first
    return img.nil? ? ProductImage.new : img
	end
  
  # tra ve ten
  def get_name
    return self.short_name
  end
  
  # tra ve danh sach san pham duoc hien thi
  def self.get_active
  	self.where(archived: false)
  end
end