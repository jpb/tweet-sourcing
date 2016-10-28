class TweetCreated < ApplicationEvent
  class Data < Data
    attribute :uuid, String, default: SecureRandom.uuid
    attribute :text, String

    validates_presence_of :uuid, :text
  end

  subscribe do |event|
    Tweet.create!(uuid: event.data[:uuid], text: event.data[:text])
  end
end
