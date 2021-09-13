class ProductImagesController < ApplicationController
  before_action :set_product_image, only: [:image]
  
  def image
    send_file @product_image.image_path(params[:type]), disposition: 'inline'
  end
  
  private
    def set_product_image
      @product_image = ProductImage.find(params[:id])
    end
end