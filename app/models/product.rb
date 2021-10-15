class Product < ApplicationRecord
  self.table_name = 'erp_products_products'
  belongs_to :category, class_name: 'Category'
  belongs_to :brand, class_name: 'Brand'
  has_many :product_images
  has_many :products_values, -> {order 'erp_products_products_values.id'}

  def self.brand_related_products_for_sold_out(product)
    self.where(category_id: product.category).where(brand_id: product.brand).where.not(id: product).order('erp_products_products.created_at desc')
  end

  def self.category_related_products_for_sold_out(product)
    self.where(category_id: product.category).where.not(id: product).order('erp_products_products.created_at desc')
  end

  def self.brand_related_products_for_not_sold_out(product)
    self.where(category_id: product.category, is_sold_out: false).where(brand_id: product.brand).where.not(id: product).order('erp_products_products.created_at desc')
  end

  def self.category_related_products_for_not_sold_out(product)
    self.where(category_id: product.category, is_sold_out: false).where.not(id: product).order('erp_products_products.created_at desc')
  end

  def self.category_newest_related_products(product)
    self.where(category_id: product.category, is_new: true).where(brand_id: product.brand).where.not(id: product).order('erp_products_products.created_at desc')
  end
  
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
  
  def self.get_printer_products
    arr = [221, 237, 82]
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

  def product_long_descipriton_values_array
    groups = []
    return [] if self.category.nil? || self.category.property_groups.count == 0

    property_group = self.category.property_groups

    property_group.where(is_filter_specs: false).each do |group|
      row = {}
      row[:group] = group
      row[:properties] = []
      group.properties.each do |property|
        row2 = {}
        row2[:property] = property
        row2[:values] = self.products_values_by_property(property).map {|pv| pv.properties_value.value }

        row[:properties] << row2 if !row2[:values].empty?
      end
      groups << row if !row[:properties].empty?
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

  # tra ve ket qua gia niem yet
  def product_listed_price
    return self.listed_price
  end

  def product_discount_price
    return self.product_listed_price - self.product_price
  end

  def product_discount_percent
    return 0 if self.listed_price.to_f == 0
    ((self.product_listed_price.to_f - self.product_price.to_f)/self.product_listed_price.to_f) * 100
  end

  def find_all_menus
		self.category.nil? ? nil : self.category.menus
	end

  def find_menu
		if !self.find_all_menus.nil?
			all_menus = self.find_all_menus
			if self.brand_id?
				menus = all_menus.where(brand_id: self.brand_id)
			end
			menus = all_menus if menus.empty?
	
			menus.last
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

  def get_short_name
    if self.custom_title.present?
      return self.custom_title
    else
      return self.short_name
    end
  end

  def get_brand_name
    return self.brand.get_name
  end

  
  # tra ve danh sach san pham duoc hien thi
  def self.get_active
  	self.where(archived: false).where(is_sold_out: false)
  end
end