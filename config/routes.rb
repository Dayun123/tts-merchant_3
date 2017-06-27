Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: 'admin', path: 'admin' do
    resources :products
    resources :brands
    resources :categories
  end

  root 'admin/products#index'
end
