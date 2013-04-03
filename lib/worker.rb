class Worker
  def initialize(queue = Queue.new)
    @queue = queue
    @threads = []
  end

  def spawn(count)
    count.times do
      @threads << Thread.new { work }
    end
  end

  def <<(json)
    @queue << json
  end

  def pool_size
    @threads.count(&:alive?)
  end

  def queue_size
    @queue.size
  end

  private

  def work
    while job = @queue.pop
      job.run
    end
  end
end
