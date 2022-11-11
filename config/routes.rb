Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tasks#index'

  resources :tasks
  put '/done', to: 'tasks#done', as: :done_task
end
