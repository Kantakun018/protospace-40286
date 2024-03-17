class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototypes_path(@comment.prototype_id) 
    else

      # 何を書いているか不明だが、これがないとインスタンス変数がなくてビューがエラーになる
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end

  private
  def comment_params
    #ここで、@commentを見ると、id: nil, content: "ddd", prototype_id: nil, user_id: 1, created_at: nil, updated_at: nil>でnilがおかしい
    #paramsにprototype_idが入っていないのが原因そう
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
