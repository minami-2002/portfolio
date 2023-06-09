class ReviewsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @reviews = Review.page(params[:page]).reverse_order
    
  end

  def show
    @review = Review.find(params[:id])
    @user = @review.user
    @post_comment = PostComment.new
  end

  def edit
    @review = Review.find(params[:id])
    unless @review.user == current_user
      redirect_to reviews_path
    end
  end
  
  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @reviews = Review.all
    if @review.save
     redirect_to review_path(@review), notice: 'You have created review successfully.'
    else
     render :new
    end 
  end
  
  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
    redirect_to review_path(@review), notice: 'You have updated review successfully.'
    else
    render :edit
    end
  
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path, notice: 'You have destroyed review successfully.'
  end
  
  private
  
  def review_params
    params.require(:review).permit(:title, :review)
  end  
end
