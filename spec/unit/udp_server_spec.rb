require "spec_helper"

describe UDPServer do
  let(:app) { stub }
  let(:server) { UDPServer.new(app) }
  let(:socket) { UDPSocket.new }

  describe "#listen" do
    it "binds to the given port" do
      Thread.new { server.listen(48777) }

      eventually do
        system("lsof -p #{$PID} | grep -q 48777").should be_true
      end
    end

    it "calls the app with incoming requests" do
      app.should_receive(:call) { |data|
        data.first.should eq("Testing")
      }

      thread = Thread.new { server.listen(48778) }

      eventually do
        system("lsof -p #{$PID} | grep -q 48778").should be_true
      end

      socket.send("Testing", 0, "127.0.0.1", 48778)
      thread.join(0.05)
    end
  end

  describe "#send" do
    it "sends a message to a host and port with the specified flags" do
      socket.bind("0.0.0.0", 48790)
      server.send("Testing", "127.0.0.1", 48790)

      eventually do
        message, _ = socket.recvfrom_nonblock(16)
        message.should eq("Testing")
      end
    end
  end
end
