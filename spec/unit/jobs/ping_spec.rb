require "spec_helper"

describe Jobs::Ping do
  let(:server) { stub }
  let(:message) { "PING" }
  let(:client) { Client.new(["AF_INET", 5055, "127.0.0.1", "127.0.0.1"]) }
  let(:job) { Jobs::Ping.new(client, message, server) }

  it "responds PONG to the client" do
    server.should_receive(:send).with("PONG", "127.0.0.1", 5055)
    job.run
  end
end
