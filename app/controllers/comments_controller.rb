class CommentsController < ApplicationController
	  before_action :authenticate_user, only: [:create]
    before_action :author_comment, only: [:edit, :update, :destroy]


  def index
    @gossip = Gossip.find(params[:id])
    @comments = @gossip.comments
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comments = @gossip.comments
  end

  def new
    @gossip = Gossip.find(params[:id])
    @comment = @gossip.comment.new
  end

  def create
    @comment = Comment.create(content: params[:content], user_id: session[:user_id] , gossip_id: params[:gossip_id])
    redirect_to gossip_path(params[:gossip_id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    comment_params = params.permit(:content)

      if @comment.update(comment_params)
        redirect_to gossip_path(params[:gossip_id])
      else
        render :edit
      end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to gossip_path(params[:gossip_id])
  end

  def authenticate_user
      unless current_user
        flash[:danger] = "Please log in."
        redirect_to new_session_path
    end
  end

  def author_comment
    @comment = Comment.find(params[:id])
    unless current_user == @comment.user
        flash[:danger] = "Tu n'es pas l'auteur de ce commentaire."
        redirect_to root_path
    end
  end

end
