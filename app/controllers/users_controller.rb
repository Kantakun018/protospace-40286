class UsersController < ApplicationController
  def show
    #コメントのIDが取れてしまっているため、Commentテーブルにあるuser_id列を取得したい
    @user = User.find(params[:id])
    #Prototypeモデルから、ユーザーが合致するものだけ取得したい
    # @prototypes = Prototype.find(params[:id])
  end
end
