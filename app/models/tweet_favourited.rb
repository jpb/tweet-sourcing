class TweetFavourited < ApplicationEvent
  subscribe do |event|
    tweet = Tweet.find_by_uuid!(event.data[:tweet_uuid])
    tweet.favourites << Favourite.new
  end
end
