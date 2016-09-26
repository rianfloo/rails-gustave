class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :create ]

  def home
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    if @user.save
      flash[:success] = "Merci pour votre inscription!"
      redirect_to root_path
    else
      render :home
    end
  end

  def dashboard
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end

end
