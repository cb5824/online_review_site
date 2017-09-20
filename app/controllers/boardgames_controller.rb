require 'pry'
class BoardgamesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search] && params[:search] != ''
      @boardgames = Boardgame.search(params[:search])
    else
      @boardgames = Boardgame.all
    end
  end

  def new
    @boardgame = Boardgame.new
  end

  def create
    @boardgame = Boardgame.new(boardgame_params)
    @boardgame.user = current_user
    if @boardgame.save
      redirect_to @boardgame, notice: 'Boardgame was successfully added.'
    else
      # binding.pry
      @errors = @boardgame.errors.full_messages
      render action: 'new'
    end
  end

  def show
    @review = Review.new
    @boardgame = Boardgame.find(params[:id])
    @reviews = @boardgame.reviews.order('created_at desc')
    @user = current_user
  end

  def update
    @boardgame = Boardgame.find(params[:id])
    if @boardgame.update_attributes(boardgame_params)
      redirect_to @boardgame, notice: 'Boardgame was updated successfully.'
    else
      @errors = @boardgame.errors.full_messages
      render action: 'edit'
    end
  end

  def edit
    @boardgame = Boardgame.find(params[:id])
  end

  def destroy
    @boardgame = Boardgame.find(params[:id])
    @reviews = @boardgame.reviews
    @boardgame.destroy
    @reviews.each do |review|
      review.destroy
    end
    redirect_to boardgames_path, notice: "Boardgame deleted successfully"
  end

  private

  def boardgame_params
  params.require(:boardgame).permit(:title, :genre, :publisher, :player_count, :duration, :msrp)
  end

end
