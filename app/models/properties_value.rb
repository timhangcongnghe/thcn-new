class PropertiesValue < ApplicationRecord
  self.table_name = 'erp_products_properties_values'
  belongs_to :property
  has_many :products_values
  has_many :products, through: :products_values, class_name: 'Product'
  has_many :products, through: :products_values
end