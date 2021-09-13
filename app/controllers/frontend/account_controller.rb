module Frontend
  class AccountController < FrontendController
    def login
      @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-account thcn-page thcn-no-js wpisset wpisset-my-account wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
    end
    
    def register
      @class = ''
    end
  end
end