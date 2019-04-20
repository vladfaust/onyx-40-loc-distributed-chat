require "onyx/http"
require "onyx/eda/redis" # This requires REDIS_URL environment variable

struct Message
  include Onyx::EDA::Event

  getter username, content

  def initialize(@username : String, @content : String)
  end
end

class Chat
  include Onyx::HTTP::Channel

  params do
    query do
      type username : String
    end
  end

  getter! sub : Onyx::EDA::Channel::Subscription(Message)

  def on_open
    @sub = Onyx::EDA.redis.subscribe(Message) do |message|
      socket.send("#{message.username}: #{message.content}")
    end
  end

  def on_message(message)
    Onyx::EDA.redis.emit(Message.new(params.query.username, message))
  end

  def on_close
    sub.unsubscribe
  end
end

Onyx::HTTP.ws "/", Chat
Onyx::HTTP.listen(port: ENV["PORT"].to_i) # You'll also need PORT variable to be set
