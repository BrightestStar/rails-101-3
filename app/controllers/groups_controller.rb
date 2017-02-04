class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :update, :edit, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.order("created_at DESC")
  end

  def edit
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path
    end

    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path
    end

    @group.destroy

    redirect_to groups_path
  end



  private

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
