Rails.application.routes.draw do
  root to: 'frontend/home#index'
  
  get '/danh-sach-chuyen-muc' => 'frontend/category#index', as: :category
  get '/danh-sach-san-pham' => 'frontend/category#list', as: :category_list
  
  get '/chi-tiet-san-pham' => 'frontend/product#index', as: :product
  get '/tim-kiem' => 'frontend/product#list', as: :product_search
end