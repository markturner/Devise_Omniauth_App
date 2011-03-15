Junket::Application.routes.draw do
  
  match 'account' => 'authentications#index'
  match '/users/auth/:provider/callback' => 'authentications#create'
  
  devise_for :users, :controllers => { :registrations => 'registrations' } do
    get 'login', :to => 'devise/sessions#new'
    get 'logout', :to => 'devise/sessions#destroy'
    get 'register', :to => 'registrations#new'
  end

  root :to => 'home#index'
  
  resource :home  
  resources :authentications

end
