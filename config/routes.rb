Rails.application.routes.draw do
  get root to: 'cards#top'
  post '/', to: 'cards#check'
  mount API::Root => '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
