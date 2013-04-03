require "spec_helper"

describe Jobs do
  describe ".factory" do
    context "when the command is PING" do
      it "returns an instance of Jobs::Ping" do
        request = Request.new("PING")
        Jobs.factory(stub, request).should be_an_instance_of(Jobs::Ping)
      end
    end
  end

  context "when the command is SEND" do
    it "returns an instance of Jobs::Send" do
      request = Request.new("SEND")
      Jobs.factory(stub, request).should be_an_instance_of(Jobs::Send)
    end
  end

  context "any other command" do
    it "returns NullJob" do
      request = Request.new("SHUTDOWN")
      Jobs.factory(stub, request).should be_an_instance_of(Jobs::NullJob)
    end
  end
end
