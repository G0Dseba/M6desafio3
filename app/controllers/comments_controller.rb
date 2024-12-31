class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post

  # GET /comments or /comments.json
  def index
    @comments = @post.comments
  end

  # GET /comments/1 or /comments/1.json
  def show
    @comment = @post.comments.find(params[:id])
  end

  # GET /comments/new
  def new
    @comment = @post.comments.build
  end

  # GET /comments/1/edit
  def edit
    @comment = @post.comments.find(params[:id])
  end

  # POST /comments or /comments.json
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user if user_signed_in?

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: "Comentario creado exitosamente." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @post, notice: "Comentario actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy!
    respond_to do |format|
      format.html { redirect_to @post, notice: "Comentario eliminado exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
