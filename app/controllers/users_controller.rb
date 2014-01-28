class UsersController < ApplicationController

  #TODO enable when admin control is implemented
  def index
    render json: ResponseGeneratorController.generate_response(false, 0, "You are not authorized for this action")
    # @users = User.all
    # response = nil
    # if @users
    #   response = {users: @users}
    # else
    #   response = ResponseGeneratorController.generate_response(true, 0, "Listing users failed")
    # end
    # respond_to do |format|
    #   format.json {render json: response}
    # end
  end

  def create
    response = nil
    remember_token = nil
    begin
      @user = User.find_by!(email: params[:user][:email])
    rescue ActiveRecord::RecordNotFound
      @user = User.new(user_params)
      if params[:user].has_key?(:remember_token)
        @user.remember_token = User.encrypt(params[:user][:remember_token])
        if @user.save
          response = ResponseGeneratorController.generate_response(true, 0, "User registered successfully.")
        else 
          response = ResponseGeneratorController.generate_response(false, 0, "User creation failed. #{@user.errors.full_messages if !@user.nil?}")
        end
      else 
        response = ResponseGeneratorController.generate_response(false, 0, "User creation failed. Remember token not found.")
      end
    else
      if @user && !@user.errors.any?
        response = ResponseGeneratorController.generate_response(true, 0, "User is already registered.")
      else
        response = ResponseGeneratorController.generate_response(false, 0, "User creation failed. #{@user.errors.full_messages if !@user.nil?}")
      end
    end
    respond_to do |format|
      format.json {render json: response}
    end
  end

  def update
    response = nil
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      response =  ResponseGeneratorController.generate_response(false, 0, "You are not authorized for this action.")
    else
      if correct_user(params[:id], params[:user][:remember_token])
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
            response = {user: @user, except: [:remember_token]}
          else
            response = ResponseGeneratorController.generate_response(false, 0, "User updation failed. #{@user.errors.full_messages if !@user.nil?}")
          end
        else
          response = ResponseGeneratorController.generate_response(false, 0, "User updation failed. #{@user.errors.full_messages if !@user.nil?}")    
        end
      else
        response = ResponseGeneratorController.generate_response(false, 0, "You are not authorized for this action.")
      end
      
    end
    respond_to do |format|
      format.json {render json: response}
    end
  end

  def show
    response = nil
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      response = ResponseGeneratorController.generate_response(false, 0, "You are not authorized for this action.")
    else
      if correct_user(params[:id], params[:remember_token])
        if @user && !@user.errors.any?
          response = {user: @user}
        else
          response = ResponseGeneratorController.generate_response(false, 0, "Could not find user")
        end
      else
        response = ResponseGeneratorController.generate_response(false, 0, "You are not authorized for this action")
        
      end
    end
    respond_to do |format|
      format.json {render json: response, except: [:remember_token]}
    end
  end

  def destroy
    response = nil
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      response = ResponseGeneratorController.generate_response(false, 0, "You are not authorized for this action.")
    else
      if correct_user(params[:id], params[:remember_token])
        if @user && !@user.errors.any?
          if @user.destroy
            response = ResponseGeneratorController.generate_response(true, 0, "User deleted successfully")
          else
            response = ResponseGeneratorController.generate_response(false, 0, "Deleting user failed")
          end
        end
      else
        response = ResponseGeneratorController.generate_response(false, 0, "You are not authorized for this action")
      end
      
    end
    respond_to do |format|
        format.json {render json: response}
      end
  end

  def user_params
    begin
      params.require(:user).permit(:name, :email, :remember_token)
    rescue ActionController::ParameterMissing
      return
    end
  end
end
