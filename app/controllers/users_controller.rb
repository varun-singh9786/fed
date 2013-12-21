class UsersController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.json {render json: @users}
    end
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      format.json {render json: params}
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
