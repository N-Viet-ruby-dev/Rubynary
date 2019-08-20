# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user, only: %i[edit update destroy]
  before_action :check_lead_comtor

  def index
    @users = User.order(created_at: :desc)
  end

  def edit; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @users = User.order(created_at: :desc)
      respond_to do |format|
        format.js
      end
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(user_params)
      @users = User.order(created_at: :desc)
      respond_to do |format|
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:error] = "Delete user failed!"
    end
  end

  private

  def user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :role, :password
  end
end
