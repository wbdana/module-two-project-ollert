Rails.application.routes.draw do
  # post '/shifts', to: 'shifts#show_params'
  get '/', to: 'sessions#new', as: 'login'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/signup', to: 'employees#new'
  post '/employees', to: 'employees#create'
  resources :shifts
  resources :employees
  resources :managers
  resources :stores
  resources :cities

  resources :stores do
  resources :shifts
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


# if logged in as manager -> store show page
# if logged in as employee -> employee show page
# if
