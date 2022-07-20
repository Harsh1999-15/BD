class UsersController < ApplicationController
  def index
    @users = User.all
    @books = Book.all
    #@user= User.find_by(id: current_user.id)    
  end
  def show
    #debugger
    @user =User.find(params[:id])
    @books = @user.books

  end
   def destroy
    @user = User.find(params[:id])
    @user.destroy
    if @user.destroy
      redirect_to root_url, notice: "User deleted."
    end
  end
  def edit
     @user = User.find(params[:id])
    
  end


   def update
     @user = User.find(params[:id])
     if @user.update(user_params)
       redirect_to root_path
     else
       render 'edit'
     end
   end

   private

   def user_params
     params.require(:user).permit(:username, :email,:image,:remove_image, :unique_id, :password, :password_confirmation, :remember_me)
   end
   def set_user
    @User = User.find(params[:id])
   end
end
