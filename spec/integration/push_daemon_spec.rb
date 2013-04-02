require "spec_helper"

describe "Push Daemon" do
  let(:socket) { UDPSocket.new }

  before(:all) do
    Thread.new { PushDaemon.new.start }

    eventually do
      system("lsof -p #{$PID} | grep -q 6889").should be_true
    end
  end

  describe "commands" do
    describe "PING" do
      it "responds with PONG" do
        socket.send("PING", 0, "127.0.0.1", 6889)

        eventually do
          response, _ = socket.recvfrom(8)
          response.should eq("PONG")
        end
      end
    end

    describe "SEND" do
      it "delivers the message to the Google Cloud Messaging API" do
        stub_request :post, "https://android.googleapis.com/gcm/send"

        socket.send('SEND t0k3n "Steve: What is up?"', 0, "127.0.0.1", 6889)

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
