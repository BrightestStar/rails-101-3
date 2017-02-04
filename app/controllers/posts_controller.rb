class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]

  def index
    @posts = current_user.posts
  end

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @post.group = @group
    @post.user = current_user
  end

  def update
    @post = Post.find(params[:id])
    @post.user = current_user

    if @post.update(post_params)
      redirect_to posts_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.user = current_user

    @post.destroy

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
