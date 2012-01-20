class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create, 
	:change_password]
  before_filter :correct_user, :only => [:edit, :update, :change_password]
  before_filter :admin_user, :only => [:destroy]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def new
    if(current_user)
      redirect_to root_path
    else
      @user = User.new
      @title = "Sign up"
    end
  end

  def create
    if(current_user)
      redirect_to root_path
    else
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        @title = "Sign up"
        @user.password = ""
        @user.password_confirmation = ""
        render 'new'
      end
    end
  end

  def edit
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    continue = true
    if params[:user].has_key?(:old_password)
      continue = @user.has_password?(params[:user][:old_password])
      @user.errors.add(:old_password, "is wrong.") if not continue
    end
    if continue && @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def destroy
    user = User.find(params[:id])
    if(user == current_user)
      flash[:error] = "You can't delete yourself."
    else
      user.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  def change_password
    @user = current_user
    @title = "Change Password"
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
