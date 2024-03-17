Rails.application.routes.draw do
  devise_for :users
  root to: 'prototypes#index'
  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy] do # indexは不要？ 
    #コメントがどのprototype_idに紐づくかを分かるようにするため、ネストする
    # ネストすると、URLにprototype_idが入り、commentsモデルに紐づくprototypeモデルのprototype_idをparamsに含めてコントローラで使えるようになる
    resources :comments, only: [:create]
  end
  resources :users, only: :show
end
