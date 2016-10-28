class TweetCreated < ApplicationEvent
  subscribe do |event|
    Tweet.create!(uuid: event.event_id, text: event.data[:text])
  end
end
