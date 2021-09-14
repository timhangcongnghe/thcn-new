module Frontend
  class HomeController < FrontendController
    def index
      @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset-wpb wpisset wpisset-home-ii wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-cat-menu-always-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
      
      @laptop_brands = Brand.get_laptop_brands
      @laptop_products = Menu.get_laptop_menu.get_products_for_categories(params).limit(6)
      
      @hot_menus = Menu.get_hot_menus
      
      @apple = Brand.find(16)
    end
  end
end