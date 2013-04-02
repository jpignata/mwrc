require "spec_helper"

describe UDPServer do
  let(:socket) { stub }
  let(:server) { UDPServer.new(socket) }

  describe "#bind" do
    it "binds the socket to the given port" do
      socket.should_receive(:bind).with("0.0.0.0", 15015)
      server.bind(15015)
    end
  end

  describe "#receive" do
    it "returns the last received datagram from the socket" do
      socket.should_receive(:recvfrom).with(4096)
      server.receive
    end
  end

  describe "#send" do
    it "sends the given message to the given address and port" do
      socket.should_receive(:send).with("Testing", 0, "127.0.0.1", 8080)
      server.send("Testing", "127.0.0.1", 8080)
    end
  end
end
