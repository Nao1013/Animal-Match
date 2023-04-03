Rails.application.routes.draw do
  resources :comments
  root :to => 'homes#top'

  # 施設側用devise
    devise_for :facility, controllers: {
    registrations: "facility/registrations",
    sessions: 'facility/sessions'
    }
  
  # 個人用devise
    devise_for :reader,skip: [:passwords], controllers: {
    sessions: "reader/sessions"
  }

  # 施設用ログイン後
  namespace :facility do
    resources :animals, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :facilities, only: [:index, :show, :edit, :update]
    # get '/animal_tag/:tag', to: "animals#search"
    end
  
  # 個人用ログイン後
   namespace :reader do
    resources :animals, only: [:index, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
