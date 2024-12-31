class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(like_params)
    @like.user = current_user
    @like.kind = params[:kind] if params[:kind].present?

    if @like.save
      redirect_to @post, notice: 'Reacción añadida exitosamente.'
    else
      redirect_to @post, alert: 'No se pudo añadir la reacción.'
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @post = @like.post
    @like.destroy
    redirect_to @post, notice: 'Reacción eliminada exitosamente.'
  end

  private

  def like_params
    params.require(:like).permit(:kind)
  end
end
