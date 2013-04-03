require "spec_helper"

describe Jobs::Send do
  let(:message) { 'SEND abc123 "Hello world"' }
  let(:client) { Client.new(["AF_INET", 80, "127.0.0.1", "127.0.0.1"], stub) }
  let(:job) { Jobs::Send.new(client, message) }

  it "extracts message parameters and creates a push notification" do
    push_notification = stub
    push_notification.should_receive(:deliver)

    PushNotification.
      should_receive(:new).
      with("abc123", "Hello world").
      and_return(push_notification)

    job.run
  end
end
