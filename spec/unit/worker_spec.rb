require "spec_helper"

describe Worker do
  let(:queue) { Queue.new }
  let(:worker) { Worker.new(queue) }

  it "posts submitted items to the Google Cloud Messaging API" do
    stub_request :post, "https://android.googleapis.com/gcm/send"

    json = '{"post":"body"}'

    worker << json
    worker.spawn(1)

    eventually do
      assert_requested :post, "https://android.googleapis.com/gcm/send", {
        "body" => json
      }
    end
  end

  describe "#spawn" do
    it "spawns the given number of worker threads" do
      worker.spawn(4)
      worker.pool_size.should eq(4)
    end
  end

  describe "#>>" do
    let(:queue) { stub }

    it "submits the given item for later execution" do
      item = stub
      queue.should_receive(:<<).with(item)

      worker << item
    end
  end
end
