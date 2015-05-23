Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :stories do
    get 'not_started', 'map'
    resources :placemarks do
    end
  end
end
