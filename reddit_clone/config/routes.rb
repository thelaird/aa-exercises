Rails.application.routes.draw do
  resources :users
  resources :subs, except: :destroy
  resources :posts, except: :index do
    resources :comments, only: :new
  end
  resource :session
  resources :comments, only: [:create, :show]
end
