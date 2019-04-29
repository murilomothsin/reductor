Rails.application.routes.draw do
  resources :shorts
  get 's/:key', to: 'shorts#redirect'
end
