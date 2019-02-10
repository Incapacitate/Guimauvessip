class GossipsController < ApplicationController
	before_action :authenticate_user, only: [:new]
    before_action :author_gossip, only: [:edit, :update, :destroy]

  def index
    # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
    @gossips = Gossip.all.reverse
  end

  def show
    @gossip = Gossip.find(params[:id])
    @user = @gossip.user
    @comments = @gossip.comments
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @gossip = Gossip.new
    @user_id = session[:user_id]
  end

  def create
    @gossip = Gossip.new(title: params[:title], content: params[:content], user_id: session[:user_id] )

    if @gossip.save # essaie de sauvegarder en base @gossip
      redirect_to root_path, :notice => "Potin créé !"
    else
      render 'new'
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    gossip_params = params.permit(:title, :content)

      if @gossip.update(gossip_params)
        # flash[:notice] = "Gossip mis à jour"
        redirect_to @gossip, :notice => "Gossip mis à jour"
      else
        render :edit
      end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to gossips_path
  end

  private

  def authenticate_user
    unless current_user
        flash[:danger] = "Connecte-toi ;)"
        redirect_to new_session_path
    end
  end

  def author_gossip
    @gossip = Gossip.find(params[:id])
    unless current_user == @gossip.user || current_user.id == 26
        flash[:danger] = "Tu n'es pas l'auteur de ce potin."
        redirect_to root_path
    end
  end
end
