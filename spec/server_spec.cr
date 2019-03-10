require "./spec_helper"
require "http/web_socket"

ENV["PORT"] ||= "4890"

alice_message = nil

spawn do
  sleep(1)

  alice_socket = HTTP::WebSocket.new(URI.parse("http://localhost:#{ENV["PORT"]}?username=Alice"))
  alice_socket.on_message do |message|
    alice_message = message
  end

  spawn alice_socket.run

  bob_socket = HTTP::WebSocket.new(URI.parse("http://localhost:#{ENV["PORT"]}?username=Bob"))
  spawn bob_socket.run

  bob_socket.send("Hi")
end

spawn do
  sleep(2)

  it "works" do
    alice_message.should eq "Bob: Hi"
  end

  exit
end

require "../src/server"
