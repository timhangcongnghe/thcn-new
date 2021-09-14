class PropertyGroup < ApplicationRecord
  self.table_name = 'erp_products_property_groups'
  has_many :properties, -> {order 'erp_products_properties.custom_order'}
  has_and_belongs_to_many :categories, class_name: 'Category', join_table: 'erp_products_categories_pgroups'
end