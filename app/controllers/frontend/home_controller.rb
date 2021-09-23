module Frontend
  class HomeController < FrontendController
    def index
      @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset-wpb wpisset wpisset-home-ii wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-cat-menu-always-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
      
      @categories = Menu.get_categories
      
      @laptop_brands = Brand.get_laptop_brands
      @laptop_products = Menu.get_laptop_menu.get_products_for_categories(params).limit(6)
      
      @sale_product = Product.find(9341)
      
      @hot_menus = Menu.get_hot_menus
      
      @apple = Brand.find(16).get_products_home_page
      @desktop = Category.find(242).get_products_home_page
      @workstation = Category.find(33).get_products_home_page
      @server = Category.find(90).get_products_home_page
      @aio = Category.find(32).get_products_home_page
      @monitor_pc = Category.find(196).get_products_home_page
      @monitor_signage = Category.find(134).get_products_home_page
      @camera = Category.find(204).get_products_home_page
      
      @computer_components = Product.get_computer_components
      @computer_accessories = Product.get_computer_accessories
      @network = Product.get_network_products
      @printer = Product.get_printer_products
      
      @newest_products = Product.get_newest_products
    end
  end
end