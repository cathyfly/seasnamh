#require "myLogger"
class ReviewsController < ApplicationController
  # GET /beaches/1/reviews
  def index
    # For URL like /beaches/1/reviews
    # Get the beach with id=1
    @beach = Beach.find(params[:beach_id])
    # Access all reviews for that beach
    @reviews = @beach.reviews
  end

  # GET /beaches/1/reviews/2
  def show
    @beach = Beach.find(params[:beach_id])
    # For URL like /beach/1/reviews/2
    # Find an review in beaches 1 that has id=2
    @review = @beach.reviews.find(params[:id])
  end


  # GET /beaches/1/reviews/new
  def new
    @beach = Beach.find(params[:beach_id])
    # Associate an review object with beach 1
    @review = @beach.reviews.build
  end

  # POST /beaches/1/reviews
  def create
    @beach = Beach.find(params[:beach_id])
    # For URL like /beach/1/reviews
    # Populate an review associate with beach 1 with form data
    # beach will be associated with the review
    # @review = @beach.reviews.build(params.require(:review).permit!)
    @review = @beach.reviews.build(params.require(:review).permit(:details))
    if @review.save
      # Save the review successfully
      redirect_to beach_review_url(@beach, @review)
    else
      render :action => "new"
    end

    #DESIGN PATTERN - OBSERVER - LOG TO A .TXT FILE WHEN A NEW REVIEW IS ADDED
    #logger = MyLogger.instance
    #logger.logInformation("A new review has been added  " + @beach.title)
  end

  # DELETE /beaches/1/reviews/2
  def destroy
    @beach = Beach.find(params[:beach_id])
    @review = Review.find(params[:id])
    @review.destroy
    respond_to do |format|
      format.html { redirect_to beach_reviews_path(@beach) }
      format.xml { head :ok }
    end
  end

end
