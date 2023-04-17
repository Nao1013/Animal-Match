Rails.application.routes.draw do
  root :to => 'homes#top'
  
  
  
  # 施設側用devise
    devise_for :facility, controllers: {
    registrations: "facility/registrations",
    sessions: 'facility/sessions'
    }

  # 個人用devise
    devise_for :reader, controllers: {
    registrations: "reader/registrations",
    sessions: "reader/sessions"
  }
  
  # 施設用ログイン後
  namespace :facility do
    resources :animals, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    # get "/facilities/unsubscribe" => "facilities#unsubscribe"
    # get "/facilities/withdraw" => "facilities#withdraw"
    resources :facilities, only: [:show, :edit, :update, :destroy]
    resources :favorites, only: [:index]
    resources :readers, only: [:show]
    resources :rooms, only: [:create, :show, :index] do
      resources :messages, only: [:create]
    end
    # get '/animal_tag/:tag', to: "animals#search"
  end
  
  # ゲストログイン（reader）
  devise_scope :reader do
    post 'readers/guest_sign_in', to: 'reader/sessions#guest_sign_in'
  end
  
  # ゲストログイン（facility）
  devise_scope :facility do
    post 'facilitys/guest_sign_in', to: 'facility/sessions#guest_sign_in'
  end

  # 個人用ログイン後
   namespace :reader do
    resources :animals, only: [:index, :show] do
      resource :favorites, only: [:create, :destroy]
    end
    # get "/readers/unsubscribe" => "readers#unsubscribe"
    # get "/readers/withdraw" => "readers#withdraw"
    resources :readers, only: [:edit, :show, :update, :destroy] do 
      member do
        get :favorites
      end
    end
    resources :facilities, only: [:show]
    resources :rooms, only: [:create, :show] do
      resources :messages, only: [:create]
    end
    get '/search', to: 'searchs#search'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end