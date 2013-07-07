class UsersController < ApplicationController
  before_action :authenticate
  before_action :set_user,     only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,   only: [:new, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html { render action: 'show' }
      format.json { render action: 'show', status: :created, location: @user }
    end
  end

  # GET /users/new
  def new
    @user  = User.new
    @title = "Sign up"
  end

  # GET /users/1/edit
  def edit
    @title = "Edit User"
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user) if current_user.name == @user.name
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy unless @user.name == current_user.name
    respond_to do |format|
      flash[:warning] = "User #{@user.name} was destoyed!"
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(*user_params_white_list)
  end

  # The straight params white list
  def user_params_white_list
    %i(name email fullname password password_confirmation admin)
  end

  def correct_user
    redirect_to root_path unless current_user?(@user) or current_user.admin?
  end
  
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
