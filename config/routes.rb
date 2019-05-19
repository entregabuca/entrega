Rails.application.routes.draw do


  get 'access/home'
  
  devise_for :senders
  devise_for :companies

  devise_for :transporters

  get 'locations/geocode'
  # THIS IS THE LATEST WORKING PROJECT 

  root 'access#home'

  resources :companies do
    resources :transporters do 
      member do
        get :orders
      end      
    end
    resources :orders do
      resources :recipients
        collection do
          get :posts
          get :taken
        end
        member do
          get :take
        end      
    end
  end

  resources :senders do
    resources :orders do
      resources :recipients 
      collection do
        get :posts
        get :posted
      end      
    end
  end 

  resources :transporters do
    resources :orders 
  end
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
