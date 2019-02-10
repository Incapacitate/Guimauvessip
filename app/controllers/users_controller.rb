class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    puts "*" * 60
    puts params
    puts "*" * 60
    @user = User.new(first_name: params[:first_name],
                     last_name: params[:last_name],
                     description: params[:description],
                     email: params[:email],
                     age: params[:age],
                     password: params[:password],
                     city_id: City.all.sample.id)

    if @user.save # essaie de sauvegarder en base @gossip
      log_in(@user)
      redirect_to root_path, :notice => "Bienvenue #{@user.first_name} !"
    else
      render 'new'
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end
end
