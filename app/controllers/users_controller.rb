class UsersController < ApplicationController
   before_action :set_user, only: [:show, :edit, :update, :destroy]
   before_action :require_user, only: [:edit, :update]
   before_action :require_same_user, only: [:edit, :update, :destroy]

   def index
      @users = User.paginate(page: params[:page], per_page: 3)
   end

   def new
      @user = User.new
   end 

   def create
      @user = User.new(params.require(:user).permit(:name, :email, :password))
      if @user.save
         session[:user_id] = @user.id
         flash[:notice] = "Welcome to alpha blog #{@user.name}, you have successfully sign up"
         redirect_to articles_path
      else
         render 'new'
      end
   end

   def edit
   end

   def update
      if @user.update(params.require(:user).permit(:name, :email, :password))
         flash[:notice] = "Your account information was successfully updated"
         redirect_to @user
      else
         render 'edit'
      end
   end

   def show
      @articles = @user.articles.paginate(page: params[:page], per_page: 3)  
   end

   def destroy
      @user.destroy
      session[:user_id] = nil if @user == current_user
      flash[:notice] = "User account and all the associated articles are deleted"
      redirect_to articles_path
   end
   private
   def set_user
      @user = User.find(params[:id])
   end

   def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit and delete your own account"
      redirect_to @user
    end
  end
end