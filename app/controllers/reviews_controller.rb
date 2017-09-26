class ReviewsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
  end

  def show
    @review = Review.find(params[:id])
  end

  def create
    @boardgame = Boardgame.find(params[:boardgame_id])
    @review = Review.new(review_params)
    @review.boardgame = @boardgame
    @review.user = current_user

    if @review.save
      redirect_to @boardgame, notice: 'Review saved successfully'
    else
      @errors = @review.errors.full_messages
      render 'boardgames.show'
    end
  end

  def edit
    @boardgame = Boardgame.find(params[:boardgame_id])
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @boardgame = @review.boardgame
    if @review.update_attributes(review_params)
        # if update is successful
        redirect_to @boardgame, notice: 'Review updated successfully'
    else
      @errors = @review.errors.full_messages
      render action: 'edit'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @boardgame = @review.boardgame
    user = current_user
    if user == @review.user || user.role == 'admin'
      @review.destroy
      redirect_to @boardgame, notice: 'Review deleted'
    else
      redirect_to edit_boardgame_review_path, notice: 'You must be the original user or have admin privileges to delete this review'
    end
  end

  def count_votes
    @review = Review.find(params[:id])
    votes =Vote.where(review_id: @review.id)
    total = 0
    votes.each do |vote|
      if vote.vote_score
        total += 1
      else
        total -= 1
      end
    end
    total
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :boardgame_id)
  end

end
