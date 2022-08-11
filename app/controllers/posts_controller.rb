class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
  end

  def create
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new(content: params[:content], user_id: @current_user.id)
    if @post.save
      redirect_to("/posts")
    else 
      flash[:notice] = "post should be between 1 - 140 characters"
      render("posts/index")
    end
  end


  


end
