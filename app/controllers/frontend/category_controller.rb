module Frontend
  class CategoryController < FrontendController
    # layout 'check', only: [:list]
    def index
      @class = ''
    end
    
    def list
      @class = 'archive post-type-archive post-type-archive-product wp-custom-logo wp-embed-responsive theme-eletra thcn-shop thcn thcn-page thcn-no-js wpisset wpisset-aplle-iphone-12-64-gb-green wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpisset-wpb wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
      @categories = Menu.get_categories
      @newest_products = Product.get_newest_products

      @category = Menu.find(params[:category_id])
      @products = Kaminari.paginate_array(@category.get_products_for_categories(params)).page(params[:page]).per(36)

      @related_categories = @category.get_children

      
    end
  end
end