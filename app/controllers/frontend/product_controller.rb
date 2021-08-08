module Frontend
  class ProductController < FrontendController
    # layout 'check', only: [:index]
    def index
      @class = 'product-template-default single single-product wp-custom-logo wp-embed-responsive theme-eletra thcn thcn-page thcn-no-js wpisset wpisset-samsong-galaxy-s20-5g-128-gb-black wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-product-type-extented wpisset-product-sticky-active wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
    end
    
    def search
      @class = ''
    end
  end
end