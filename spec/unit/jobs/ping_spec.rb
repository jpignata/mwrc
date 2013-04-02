require "spec_helper"

describe Jobs::Ping do
  let(:server) { stub }
  let(:data) { ["PING", ["AF_INET", 5055, "127.0.0.1", "127.0.0.1"]] }
  let(:job) { Jobs::Ping.new(data, server) }

  it "responds PONG to the client" do
    server.should_receive(:send).with("PONG", "127.0.0.1", 5055)
    job.run
  end
end
