Rails.application.routes.draw do
  root :to => 'homes#top'

  devise_for :facility, controllers: {
  registrations: "facility/registrations",
  sessions: 'facility/sessions'
  }

  devise_for :reader, controllers: {
  sessions: "reader/sessions"
}

namespace :facility do
  resources :animals, only: [:index, :show, :new, :create, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
