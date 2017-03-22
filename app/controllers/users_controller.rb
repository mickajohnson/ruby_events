class UsersController < ApplicationController
  def new
    @states = states
  end

  def edit
    @states = states
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
  end

  def login
    user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:errors] = ["Invalid email or password"]
      redirect_to :back
    end
  end

  def update
    user = User.find(params[:id]).update(user_params)
    if user
      redirect_to '/'
    else
      flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
  end

  def logout
    session.clear
    redirect_to '/users'
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
  end
end
