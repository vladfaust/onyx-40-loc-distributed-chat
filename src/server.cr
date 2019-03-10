require "onyx/http"
require "onyx/eda"

Onyx.channel(:redis) # You'll need REDIS_URL variable to be set

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

  def on_open
    Onyx.subscribe(self, Message) do |message|
      socket.send("#{message.username}: #{message.content}")
    end
  end

  def on_message(message)
    Onyx.emit(Message.new(params.query.username, message))
  end

  def on_close
    Onyx.unsubscribe(self)
  end
end

Onyx.ws "/", Chat
Onyx.listen(port: ENV["PORT"].to_i) # You'll also need PORT variable
