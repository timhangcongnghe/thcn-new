class ProductsProperty < ApplicationRecord
    self.table_name = 'erp_products_products_properties'
    belongs_to :product
    belongs_to :property
    has_many :products_values
  end