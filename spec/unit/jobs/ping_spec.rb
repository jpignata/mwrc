require "spec_helper"

describe Jobs::Ping do
  let(:client) { Client.new(["AF_INET", 5055, "127.0.0.1", "127.0.0.1"], stub) }
  let(:request) { Request.new("PING") }
  let(:job) { Jobs::Ping.new(client, request) }

  it "responds PONG to the client" do
    client.should_receive(:send).with("PONG")
    job.run
  end
end
