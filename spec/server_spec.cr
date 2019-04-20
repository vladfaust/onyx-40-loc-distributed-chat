ENV["PORT"] ||= "4890"

require "spec"
require "onyx/http/spec"
require "../src/server"

describe "server" do
  alice_socket = Onyx::HTTP::Spec.ws("/?username=Alice")
  bob_socket = Onyx::HTTP::Spec.ws("/?username=Bob")

  it do
    bob_socket.send("Hello")
    alice_socket.assert_response("Bob: Hello")
  end

  it do
    alice_socket.send("Hi")
    bob_socket.assert_response("Alice: Hi")
  end
end
