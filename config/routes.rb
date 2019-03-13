Rails.application.routes.draw do
  get root to: 'cards#top'
  get  '/result', to: 'cards#result'
  get  '/error', to: 'cards#error'
  post '/check', to: 'cards#check'
  patch '/check', to: 'cards#check'
  mount API::Root => '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
