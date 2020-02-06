Rails.application.routes.draw do
  resources :home do
    get :collect_statistics, on: :collection
  end
  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
