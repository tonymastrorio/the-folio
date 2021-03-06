Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects
  resource :portfolios
  root 'projects#index'
  resources :users do
    resources :portfolios
  end

  resources :portfolios do
    resources :projects
  end


end
