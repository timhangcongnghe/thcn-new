class PropertiesValue < ApplicationRecord
  self.table_name = 'erp_products_properties_values'
  belongs_to :property
  has_many :products_values
  has_many :products, through: :products_values, class_name: 'Product'
  has_many :products, through: :products_values

  def self.get_property_values_for_filter
    self.order("value asc")
  end

  def product_count_by_menu(menu)
    ProductsValue.includes(:product)
      .where(erp_products_products: {is_sold_out: false, category_id: menu.categories.first})
      .where(properties_value: self.id).count
  end

  def product_count_by_menu_brand(menu)
    ProductsValue.includes(:product)
      .where(erp_products_products: {is_sold_out: false, category_id: menu.categories.first, brand_id: menu.brand.id})
      .where(properties_value: self.id).count
  end
end