Rails.application.routes.draw do

  root 'highschools#index'
  
  resources :highschools
end
