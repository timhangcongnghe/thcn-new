class ProductsValue < ApplicationRecord
  self.table_name = 'erp_products_products_values'
  belongs_to :product
  belongs_to :properties_value
end