Rails.application.routes.draw do
  root 'urls#new'
  
  resources :urls, only: [:index, :new, :create, :show]
  get '/:short_path', to: 'urls#visit', as: :visit
end
