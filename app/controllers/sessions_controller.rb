class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_e_mail(params[:e_mail])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/"
    else 
      redirect_to "/login"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/login"
  end
end
