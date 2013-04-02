require "spec_helper"

describe "Push Daemon" do
  let(:push_daemon) { TestDaemon.new(6889) }

  before do
    push_daemon.start

    eventually do
      push_daemon.should be_ready
    end
  end

  describe "commands" do
    describe "PING" do
      it "responds with PONG" do
        push_daemon.send("PING")

        eventually do
          push_daemon.last_response.should eq("PONG")
        end
      end
    end

    describe "SEND" do
      it "delivers the message to the Google Cloud Messaging API" do
        stub_request :post, "https://android.googleapis.com/gcm/send"

        push_daemon.send('SEND t0k3n "Steve: What is up?"')

        eventually do
          assert_requested :post, "https://android.googleapis.com/gcm/send", {
            headers: {
              "Authorization" => "key=AIzaSyCABSTd47XeIH",
              "Content-Type"  => "application/json"
            },
            body: {
              "registration_ids" => ["t0k3n"],
              "data" => {
                "alert" => "Steve: What is up?"
              }
            }.to_json
          }
        end
      end
    end
  end
end
