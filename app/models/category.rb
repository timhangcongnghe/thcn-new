class Category < ActiveRecord::Base
  self.table_name = 'erp_products_categories'
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  
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