class RetweetsController < ApplicationController
  before_action :set_retweet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /retweets
  # GET /retweets.json
  def index
    @retweets = Retweet.all.order(created_at: :DESC)
    @tweet = Retweet.new
    @users = User.all_except(current_user)
  end

  # GET /retweets/1
  # GET /retweets/1.json
  def show
  end

  # GET /retweets/new
  def new
    @retweet = Retweet.new(tweet_id: params[:id].to_i, user_id: current_user.id)
    @retweet.save
  end

  # GET /retweets/1/edit
  def edit
    @retweets = Retweet.all.order(created_at: :DESC)
    @users = User.all_except(current_user)
  end

  # PATCH/PUT /retweets/1
  # PATCH/PUT /retweets/1.json
  def update
    respond_to do |format|
      if @retweet.update(tweet_params)
        format.html { redirect_to retweets_path, notice: 'Retweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @retweet }
      else
        format.html { render :edit }
        format.json { render json: @retweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retweets/1
  # DELETE /retweets/1.json
  def destroy
    @retweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Retweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @retweets = Retweet.search params[:search]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_retweet
      @retweet = Retweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def retweet_params
      params.require(:retweet).permit(:retweeet)
    end
end
