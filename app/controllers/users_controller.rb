class UsersController < ApplicationController

    before_action :authenticate_user!
    before_action :correct_post, only: [:edit]

  def index
    @user = User.find_by(id: current_user.id)
    @users = User.all
    @newbook = Book.new

  end

  def show
    @user = User.find(params[:id])
    @newbook = Book.new
    @books = Book.where(user_id: @user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end

  end




def correct_post
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
end




  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
