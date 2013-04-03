require "spec_helper"

describe Client do
  let(:sockaddr) { ["AF_INET", 80, "www.example.com", "192.0.43.10"] }
  let(:client) { Client.new(sockaddr) }

  describe "#address" do
    it "returns the IP address of the client" do
      client.address.should eq("192.0.43.10")
    end
  end

  describe "#port" do
    it "returns the port of the client" do
      client.port.should eq(80)
    end
  end
end
