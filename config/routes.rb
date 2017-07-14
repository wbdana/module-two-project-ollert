Rails.application.routes.draw do
  # post '/shifts', to: 'shifts#show_params'
  get '/', to: 'sessions#new', as: 'login'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/signup', to: 'employees#new'
  post '/employees', to: 'employees#create'
  post '/shifts/destroy', to: 'shifts#destroy', as: 'destroy'
  resources :employees
  resources :managers
  resources :cities
  resources :stores, only: [:index, :show] do
  resources :shifts, only: [:index, :edit, :new, :create, :show]
  get "*path" => redirect("/")
  end



  # resources :stores, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


# if logged in as manager -> store show page
# if logged in as employee -> employee show page
# if
