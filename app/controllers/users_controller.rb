class UsersController < ApplicationController
   def index
      @users = User.all
   end

   def new
      @user = User.new
   end 

   def create
      @user = User.new(params.require(:user).permit(:name, :email, :password))
      if @user.save
         flash[:notice] = "Welcome to alpha blog #{@user.name}, you have successfully sign up"
         redirect_to articles_path
      else
         render 'new'
      end
   end

   def edit
      @user = User.find(params[:id])
   end

   def update
      @user = User.find(params[:id])
      if @user.update(params.require(:user).permit(:name, :email, :password))
         flash[:notice] = "Your account information was successfully updated"
         redirect_to @user
      else
         render 'edit'
      end
   end

   def show
      @user = User.find(params[:id])
      @articles = @user.articles  
   end
end