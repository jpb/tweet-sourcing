class TweetFavourited < ApplicationEvent
  class Data < Data
    attribute :tweet_uuid, String

    validates_presence_of :tweet_uuid
  end

  subscribe do |event|
    tweet = Tweet.find_by_uuid!(event.data[:tweet_uuid])
    tweet.favourites << Favourite.new
  end
end
