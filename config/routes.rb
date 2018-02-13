Rails.application.routes.draw do
  get 'new', to: 'games#new', as: :new
  get 'score', to: 'games#score', as: :score
  root to: 'games#new'
end








