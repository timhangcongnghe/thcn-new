class CategoriesPgroup < ApplicationRecord
  self.table_name = 'erp_products_categories_pgroups'
  belongs_to :category, class_name: 'Category'
  belongs_to :property_group, class_name: 'PropertyGroup'
end