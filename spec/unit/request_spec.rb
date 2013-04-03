require "spec_helper"

describe Request do
  describe "#command" do
    it "returns the extracted command from the message" do
      Request.new("SEND abc123 Testing").command.should eq("SEND")
      Request.new("PING").command.should eq("PING")
      Request.new('SEND abc123 "a multiple word token"').command.should eq("SEND")
    end

    it "normalizes the command to an upcased string" do
      Request.new("send").command.should eq("SEND")
      Request.new("pInG").command.should eq("PING")
    end

    context "an empty message" do
      it "returns an empty string" do
        Request.new("").command.should eq("")
      end
    end
  end

  describe "#parameters" do
    context "with no parameters" do
      it "returs an empty array" do
        Request.new("PING").parameters.should eq([])
      end
    end

    context "with one parameter" do
      it "returns an array with the parameter" do
        Request.new("PING 127.0.0.1").parameters.should eq(["127.0.0.1"])
      end
    end

    context "with two parameters" do
      it "returns an array with the two parameters" do
        Request.new("PING 127.0.0.1 1234").parameters.
          should eq(["127.0.0.1", "1234"])
      end
    end

    context "with a token that is enclosed within double quotes" do
      it "treats the quoted string as one parameter" do
        Request.new('SEND abc123 "Hello world"').parameters.
          should eq(["abc123", "Hello world"])
      end
    end
  end
end
