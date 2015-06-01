Rails.application.routes.draw do
  devise_for :users
  root to: 'welcome#index'
  resources :stories do
    get 'map'
    resources :placemarks do
    end
  end
	get 'sitemap.xml', :to => 'sitemap#index', :defaults => {:format => 'xml'}
end