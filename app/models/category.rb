class Category < ApplicationRecord
  self.table_name = 'erp_products_categories'
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  has_many :products
  has_and_belongs_to_many :property_groups, -> {order 'erp_products_property_groups.custom_order'}, class_name: 'PropertyGroup', join_table: 'erp_products_categories_pgroups'
  
  def get_self_and_children_ids
    ids = [self.id]
    ids += get_children_ids_recursive
    return ids
	end
  
  def get_children_ids_recursive
    ids = []
    children.each do |c|
			if !c.children.empty?
				ids += c.get_children_ids_recursive
			end
			ids << c.id
		end
    return ids
	end
end