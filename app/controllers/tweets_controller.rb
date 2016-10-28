class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    event = TweetCreated.call(tweet_params)
    # This is kind of awkward
    @tweet = Tweet.find_by_uuid(event.data[:uuid])

    respond_to do |format|
      format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
      format.json { render :show, status: :created, location: @tweet }
    end
  rescue ActiveModel::ValidationError => e
    respond_to do |format|
      format.html { render :new }
      format.json { render json: e.errors, status: :unprocessable_entity }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.fetch(:tweet, {})
    end
end
