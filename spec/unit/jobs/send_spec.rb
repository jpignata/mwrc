require "spec_helper"

describe Jobs::Send do
  let(:server) { stub }
  let(:message) { 'SEND abc123 "Hello world"' }
  let(:client) { Client.new(["AF_INET", 80, "127.0.0.1", "127.0.0.1"]) }
  let(:job) { Jobs::Send.new(client, message, server) }

  it "posts the JSON representation of the message to the Google Cloud Messaging API" do
    stub_request :post, "https://android.googleapis.com/gcm/send"

    job.run

    assert_requested :post, "https://android.googleapis.com/gcm/send", {
      "body" => {
        "registration_ids" => ["abc123"],
        "data" => {
          "alert" => "Hello world"
        }
      }.to_json
    }
  end
end
