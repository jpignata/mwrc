require "spec_helper"

describe Jobs do
  describe ".factory" do
    context "when the command is PING" do
      it "returns an instance of Jobs::Ping" do
        Jobs.factory(stub, "PING").should be_an_instance_of(Jobs::Ping)
      end
    end
  end

  context "when the command is SEND" do
    it "returns an instance of Jobs::Send" do
      Jobs.factory(stub, "SEND").should be_an_instance_of(Jobs::Send)
    end
  end

  context "any other command" do
    it "returns nil" do
      Jobs.factory(stub, "SHUTDOWN").should be_nil
    end
  end
end
