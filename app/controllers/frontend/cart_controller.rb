module Frontend
  class CartController < FrontendController
    # layout 'check', only: [:cart]
    def cart
      @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-cart thcn-page thcn-no-js wpisset wpisset-cart wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
    end
    
    def checkout
      @class = ''
    end
  end
end