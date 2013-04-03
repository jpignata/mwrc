require "spec_helper"

describe PushNotification do
  let(:push_notification) { PushNotification.new("abc123", "Hello world") }

  describe "#deliver" do
    it "delivers the push notification to the Google Cloud Messaging API" do
      stub_request :post, "https://android.googleapis.com/gcm/send"

      push_notification.deliver

      assert_requested :post, "https://android.googleapis.com/gcm/send", {
        "body" => push_notification.to_json
      }
    end
  end

  describe "#to_json" do
    it "returns the JSON representation of the push notification" do
      json = {
        "registration_ids" => ["abc123"],
        "data" => {
          "alert" => "Hello world"
        }
      }.to_json

      push_notification.to_json.should eq(json)
    end
  end
end
