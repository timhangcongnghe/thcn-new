class Product < ApplicationRecord
  self.table_name = 'erp_products_products'
  belongs_to :category
  has_many :product_images
  has_many :products_values, -> {order 'erp_products_products_values.id'}
  
  def self.get_computer_components
    arr = [100, 127, 128, 214, 215, 10, 56, 210, 211]
    return self.get_active.order('created_at desc').joins(:category).where('category.id': arr).limit(6)
  end
  
  def self.get_computer_accessories
    arr = [14, 12, 4, 65, 219, 141, 104, 57, 236]
    return self.get_active.order('created_at desc').joins(:category).where('category.id': arr).limit(6)
  end
  
  def self.get_network_products
    arr = [50, 132, 69]
    return self.get_active.order('created_at desc').joins(:category).where('category.id': arr).limit(6)
  end
  
  def self.get_newest_products
    return self.get_active.order('created_at desc').where(is_new: true).limit(10)
  end
  
  # ok
  def get_product_property_array
		arr = []
		self.get_properties.each do |property|
			row = {
				name: property.name,
				values: self.products_values_by_property(property).map {|products_value|
					products_value.properties_value.value
				}
			}
			arr << row
		end
		arr
	end
  
  # ok
  def products_values_by_property(property)
		self.products_values.joins(:properties_value).where(erp_products_properties_values: {property_id: property.id})
	end
  
  def product_short_descipriton_values_array_new_specs
    groups = []
    return [] if self.category.nil? || self.category.property_groups.count == 0
    
    property_group = self.category.property_groups.first
    property_group.properties.where(is_show_detail: true).each do |property|
      row = {}
      row[:name] = property.name
      row[:values] = []
      
      values = self.products_values_by_property(property).map {|pv| pv.properties_value.value }
      row[:values] += values if !values.empty?
      groups << row if !row[:values].empty?
    end
    return groups
  end
  
  # lay danh sanh thuoc tinh
  def get_properties
		Property.where(id: (self.products_values.joins(:properties_value).select('erp_products_properties_values.property_id as property_id').map {|pv| pv.property_id}).uniq)
	end
  
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
  	self.where(archived: false).where(is_sold_out: false)
  end
end