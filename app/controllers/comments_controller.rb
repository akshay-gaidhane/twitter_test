class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /retweets
  # GET /retweets.json
  def index
    @comments = Comment.all.order(created_at: :DESC)
    @commnet = Comment.new
    @users = User.all_except(current_user)
  end

  # GET /retweets/1
  # GET /retweets/1.json
  def show
  end

  # GET /retweets/new
  def new
    @comment = Comment.new(tweet_id: params[:id].to_i, user_id: current_user.id)
    @comment.save
  end

  # GET /retweets/1/edit
  def edit
    @comments = Comments.all.order(created_at: :DESC)
    @users = User.all_except(current_user)
  end

  # PATCH/PUT /retweets/1
  # PATCH/PUT /retweets/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comments_path, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retweets/1
  # DELETE /retweets/1.json
  def destroy
    @comment.destroy if @comment.user_id == current_user.id
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @retweets = Comment.search params[:search]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def retweet_params
      params.require(:comment).permit(:comment)
    end
end