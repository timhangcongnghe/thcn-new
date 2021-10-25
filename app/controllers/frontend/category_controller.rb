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
      
      if !@category.not_create_link?
        if (@category.is_redirect?) && (@category.redirect_id.present?)
          redirect_to category_list_path(category_id: @category.redirect_id, category_alias: Menu.find(@category.redirect_id).alias, reid: @category, rename: @category.alias), status: 301
        end
      end

      if @category.not_create_link?
        redirect_to root_link, status: 301
      end

      if params[:re_id].present?
        @redirect_category = Menu.find(params[:re_id])
      end

      @products = Kaminari.paginate_array(@category.get_products_for_categories(params)).page(params[:page]).per(36)

      @related_categories = @category.get_children
    end
  end
end