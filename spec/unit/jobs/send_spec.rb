require "spec_helper"

describe Jobs::Send do
  let(:server) { stub }
  let(:data) { ['SEND abc123 "Hello world"', stub] }
  let(:job) { Jobs::Send.new(data, server) }

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
