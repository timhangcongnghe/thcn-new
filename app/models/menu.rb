class Menu < ApplicationRecord
  self.table_name = 'erp_menus_menus'
  belongs_to :parent, class_name: "Menu", optional: true
  has_many :children, -> {order(custom_order: :asc)}, class_name: 'Menu', foreign_key: 'parent_id'
  has_and_belongs_to_many :categories, class_name: 'Category'
  
  # lay danh sach san pham theo categories
  def get_products_for_categories(params)
		records = Product.get_active.where(category_id: self.get_all_related_category_ids)		
    if params[:sort_by].present?
			records = records.order(params[:sort_by].gsub('_', ' '))
		else
			records = records.order("created_at desc")
		end
		return records
	end
  
  # lay danh sach id category theo menu
  def get_all_related_category_ids
		category_ids = []
		menu_ids = self.get_self_and_children_ids
		menu_ids.each do |menu_id|
			menu = Menu.find(menu_id)
			menu.categories.each do |category|
				category_ids += category.get_self_and_children_ids
			end
		end
		return category_ids.uniq
	end
  
  # lay danh sach id menu con
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
  
  # lay danh sach toan bo menu children
  def get_children_array
    arr = []
    self.children.get_active.each do |child_1|
      arr << {menu: child_1, class: 'parent'}
      child_1.children.get_active.each do |child_2|
        arr << {menu: child_2, class: 'child'}
      end
    end
    arr
  end
  
  # lay danh sach menu children cua menu parent thoa get active
  def get_children
    self.children.get_active
  end
  
  # tra ve ten menu
  def get_name
    return self.name
  end
  
  # lay danh sach menu thoa get active va khong co parent id
  def self.get_menus
    self.get_active.where(parent_id: nil)
  end
  
  # lay menu id may tinh xach tay
  def self.get_laptop_menu
    return self.find(464)
  end
  
  # lay danh sach menu hien thi ngoai trang home
  def self.get_hot_menus
     self.get_active.where(is_hot: true).where(parent_id: nil)
  end
  
  # loc menu voi archived la false va sap xep asc cot custom order
  def self.get_active
    self.where(archived: false).order("custom_order asc")
  end
end