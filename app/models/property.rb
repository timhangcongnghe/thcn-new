class Property < ApplicationRecord
  self.table_name = 'erp_products_properties'
  belongs_to :property_group
  has_many :properties_values
end