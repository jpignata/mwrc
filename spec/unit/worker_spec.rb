require "spec_helper"

describe Worker do
  let(:queue) { Queue.new }
  let(:worker) { Worker.new(queue) }

  it "runs submitted jobs" do
    worker.spawn(1)

    job = stub
    job.should_receive(:run)

    worker << job

    eventually do
      worker.queue_size.should eq(0)
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
