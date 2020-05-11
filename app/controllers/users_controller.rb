class UsersController < ApplicationController
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
      @user = User.find(params.require(:user).permit(:name, :email, :password))
   end
end