class Brand < ApplicationRecord
  self.table_name = 'erp_products_brands'
  has_many :products, class_name: 'Product'
  
  def get_name
    return self.name
  end
  
  def self.get_laptop_brands
    # Microsoft #9, Apple #16, HP #5, Dell #3, Lenovo #2, MSI #31, Asus #41, Acer #1, Gigabyte #56, Avita #194, Dynabook #199
    arr = [16, 5, 3, 2, 31, 41, 1, 56, 194, 199, 9]
    return self.where(id: arr).get_active.order('name asc')
  end
  
  def get_products
    self.products.get_active.order('created_at desc')
  end
  
  def self.get_active
  	self.where(archived: false)
  end
end