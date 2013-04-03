module Jobs
  class Ping < Job
    def run
      @client.send("PONG")
    end
  end
end
