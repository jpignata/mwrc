class Worker
  def initialize(queue = Queue.new)
    @queue = queue
    @client = HTTPClient.new
    @threads = []
  end

  def spawn(count)
    count.times do
      @threads << Thread.new do
        while data = @queue.pop
          @client.post("https://android.googleapis.com/gcm/send", data, {
            "Authorization" => "key=AIzaSyCABSTd47XeIH",
            "Content-Type" => "application/json"
          })
        end
      end
    end
  end

  def <<(json)
    @queue << json
  end

  def pool_size
    @threads.count(&:alive?)
  end
end
