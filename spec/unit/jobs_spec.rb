require "spec_helper"

describe Jobs do
  describe ".factory" do
    context "when the command is PING" do
      it "returns an instance of Jobs::Ping" do
        data = ["PING", stub]
        Jobs.factory(data, stub).should be_an_instance_of(Jobs::Ping)
      end
    end
  end

  context "when the command is SEND" do
    it "returns an instance of Jobs::Send" do
      data = ["SEND", stub]
      Jobs.factory(data, stub).should be_an_instance_of(Jobs::Send)
    end
  end

  context "any other command" do
    it "returns nil" do
      data = ["SHUTDOWN", stub]
      Jobs.factory(data, stub).should be_nil
    end
  end
end
