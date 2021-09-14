Rails.application.routes.draw do
  root to: 'frontend/home#index'
  
  get '/danh-sach-chuyen-muc' => 'frontend/category#index', as: :category
  get '/danh-sach-san-pham' => 'frontend/category#list', as: :category_list
  
  get '/chi-tiet-san-pham' => 'frontend/product#index', as: :product
  get '/tim-kiem' => 'frontend/product#search', as: :product_search
  
  get '/gio-hang' => 'frontend/cart#cart', as: :cart
  get '/dat-hang' => 'frontend/cart#checkout', as: :checkout
  get '/dat-hang-thanh-cong' => 'frontend/cart#finish', as: :finish
  
  get '/tra-cuu-don-hang' => 'frontend/order#track', as: :track
  
  get '/gioi-thieu' => 'frontend/info#about', as: :about
  get '/lien-he' => 'frontend/info#contact', as: :contact
  
  get '/danh-sach-thuong-hieu' => 'frontend/brand#list', as: :brand_list
  get '/san-pham-thuong-hieu' => 'frontend/brand#detail', as: :brand_detail
  
  get '/huong-dan-mua-hang' => 'frontend/guide#shopping', as: :shopping_guide
  
  get '/danh-nhap' => 'frontend/account#login', as: :account_login
  get '/dang-ky' => 'frontend/account#register', as: :account_register
  
  get '/loi-404' => 'frontend/error#index', as: :error_404
  
  get "hinh-anh/:title-:id-:thumb" => "product_images#image", as: :product_image
end