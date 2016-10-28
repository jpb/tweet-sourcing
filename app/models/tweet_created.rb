class TweetCreated < ApplicationEvent
  class Data < Data
    attribute :uuid, String
    attribute :text, String

    validates_presence_of :uuid, :text
  end

  subscribe do |event|
    Tweet.create!(uuid: event.event_id, text: event.data[:text])
  end
end
