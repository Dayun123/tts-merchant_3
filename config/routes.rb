Rails.application.routes.draw do
  devise_for :users

  scope module: 'admin', path: 'admin' do
    resources :products
    resources :brands
    resources :categories
  end

  root 'admin/products#index'
end
