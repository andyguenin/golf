class GroupsController < ApplicationController
  def index
    authorize! :index, :group
    @groups = current_user.groups
  end

  def show
    @group = Group.find_by_slug(params[:id])
    authorize! :read, @group
  end

  def edit
    @group = Group.find_by_slug(params[:id])
    authorize! :update, @group
    @users = @group.users
  end

  def update
    @group = Group.find_by_slug(params[:id])
    authorize! :update, @group
    if(@group.update_attributes(params[:group]))
      redirect_to @group
    else
      render 'edit'
    end
  end

  def new
    @group = Group.new
    authorize! :create, @group
  end

  def create
    @group = Group.new(params[:group].slice(:name))
    @group.slug = params[:group][:slug]
    authorize! :create, @group
    if(@group.save)
      @group.users << current_user
      @group.admins << current_user
      redirect_to @group
    else
      render 'new'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    authorize! :destroy, @group
    @group.destroy
    redirect_to group_url
  end
end
