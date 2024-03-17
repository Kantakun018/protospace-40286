class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    #newアクションにインスタンス変数@prototypeを定義し、Prototypeモデルの新規オブジェクトを代入した？
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

# 参考：https://pikawaka.com/rails/create
# new + saveメソッドはTRUE/FALSEで結果を返すのに対し、Createメソッドはレコードを結果として返す

  def show
    # paramsをなぜ使うか復習
    @prototype = Prototype.find(params[:id])
    
    #合っている？
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)

  end

  def edit
    @prototype = Prototype.find(params[:id])

    unless current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end
  
  def update

    # インスタンス変数にしておくと、ビューで使える
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(prototype.id) 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
