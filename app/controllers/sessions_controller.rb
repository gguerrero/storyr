class SessionsController < ApplicationController
  def new
    @title = t('session.signin')
  end

  def create
    user = User.authenticate(session_params[:username],
                             session_params[:password])
    
    if user.nil?
      flash.now[:error] = "Invalid username/password combination"
      @title = t('session.signin')
      render :new
    else
      sign_in user, booleanize(session_params[:permanent])
      # For a friendly redirect, avoid "redirect_to user"
      redirect_back_or user
    end      
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private
  def session_params
    @params ||= params.require(:session).permit(*session_params_white_list)
  end

  def session_params_white_list
    %i(username password permanent)
  end
end
