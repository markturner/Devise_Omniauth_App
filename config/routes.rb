Junket::Application.routes.draw do
  
  match '/auth/:provider/callback' => 'authentications#create'
  
  devise_for :users do
    get 'login', :to => 'devise/sessions#new'
    get 'logout', :to => 'devise/sessions#destroy'
    get 'register', :to => 'devise/registrations#new'
  end

  root :to => 'home#index'
  
  resource :home  
  resources :authentications

end
