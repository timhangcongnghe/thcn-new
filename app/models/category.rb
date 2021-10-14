class Category < ApplicationRecord
  self.table_name = 'erp_products_categories'
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  has_many :products
  has_and_belongs_to_many :property_groups, -> {order 'erp_products_property_groups.custom_order'}, class_name: 'PropertyGroup', join_table: 'erp_products_categories_pgroups'
  has_and_belongs_to_many :menus, class_name: 'Menu'

  def category_get_properties_array
    groups = []
    return [] if self.nil?
    property_group = self.property_groups.where(is_filter_specs: true).first
    property_group.properties.each do |property|
      row = {}
      row[:name] = property.name
      row[:values] = []
      if property.use_custom_sort?
        values = property.properties_values.order("custom_sort ASC").get_property_values_for_filter.map {|pv| pv }
      else
        values = property.properties_values.order("custom_order ASC").get_property_values_for_filter.map {|pv| pv }
      end
      row[:values] += values if !values.empty?
      groups << row if !row[:values].empty?
    end

    return groups
  end
  
  def get_products_home_page
    self.products.get_active.order('created_at desc').limit(6)
  end
  
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