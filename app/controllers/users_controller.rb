class UsersController < ApplicationController
  def index
    @users = User.all
    response = nil

    if @users
      response = {users: @users}
    else
      response = ResponseGeneratorController.generate_response(true, 0, "Listing users failed")
    end
    respond_to do |format|
      format.json {render json: response}
    end
  end

  def create
    @user = User.create(user_params)

    response = nil
    if @user && !@user.errors.any?
      response = ResponseGeneratorController.generate_response(true, 0, "User created successfully")
    else
      response = ResponseGeneratorController.generate_response(false, 0, "User creation failed")
    end

    respond_to do |format|
      format.json {render json: response}
    end
  end

  def update
   begin
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json {render json: ResponseGeneratorController.generate_response(false, 0, "User doesn't exist")}
    end
  end

    response = nil
    user = params[:user]
    response = params
    if @user && !@user.errors.any?
      if user.has_key?(:name)
        @user.name = user[:name]
      end
      if user.has_key?(:email)
        @user.email = user[:email]
      end
      if @user.save
        response = {user: @user}
      else
        response = ResponseGeneratorController.generate_response(false, 0, "User updation failed")
      end
      respond_to do |format|
        format.json {render json: response}
      end
    end
  end

  def show
   begin
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json {render json: ResponseGeneratorController.generate_response(false, 0, "User doesn't exist")}
    end
  end

    response = nil
    if @user && !@user.errors.any?
      response = {user: @user}
    else
      response = ResponseGeneratorController.generate_response(false, 0, "Could not find user")
    end

    respond_to do |format|
      format.json {render json: response}
    end
  end

  def destroy
   begin
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json {render json: ResponseGeneratorController.generate_response(false, 0, "User doesn't exist")}
    end
  end

    response = nil
    if @user && !@user.errors.any?
      if @user.destroy
        response = ResponseGeneratorController.generate_response(true, 0, "User deleted successfully")
      else
        response = ResponseGeneratorController.generate_response(false, 0, "Deleting user failed")
      end
    end
    respond_to do |format|
      format.json {render json: response}
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
