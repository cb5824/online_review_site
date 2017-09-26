
class Api::V1::VotesController < ApplicationController

  def index
    binding.pry
    review = Review.find(params[:review_id])
    votes =Vote.where(review_id: review.id)
    render json: votes
  end

  def count_votes
    @review = Review.find(params[:review_id])
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


  def create_or_destroy
    @user_id = params[:user_id]
    @review_id = params[:review_id]
    @vote_score = (params[:vote_score] == 'true')
    @review = Review.find(@review_id)
    @game = Boardgame.find(@review.boardgame_id)
    @vote = Vote.where(:user_id=>params[:user_id]).where(:review_id=>params[:review_id]).first

    if @vote
      if @vote.vote_score == @vote_score
        @vote.destroy
      else
        @vote.vote_score = @vote_score
      end
    else
      @vote = Vote.new
      @vote.user_id = @user_id
      @vote.review_id = @review_id
      @vote.vote_score = @vote_score
      @vote.save
    end
    # respond_to do |format|
    #    format.html { redirect_to boardgame_path(@game)  }
    #    format.json { head :no_content }
    #    format.js   { render :layout => false }
    # end
    # new_total = count_votes
    # binding.pry
    # count_votes.to_json #????????
  end

  private
   def vote_params
     params.require(:vote).permit(:user_id, :review_id, :vote_score)
   end
end

# ALMOST THERE! just have to pass the data back on the ajax request and update the page.
