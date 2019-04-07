Rails.application.routes.draw do
  resources :tickets, :only => [:index, :create, :new, :show] 
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'tickets#index'

  get 'purchase' => 'purchases#index', as: 'purchase_history'

  post 'buy_ticket' => 'purchases#buy_ticket', as: 'buy_ticket'

  delete 'cancel_ticket' => 'purchases#cancel_ticket', as: 'cancel_ticket'
end
