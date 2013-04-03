module Jobs
  class Ping
    def initialize(client, request)
      @client = client
      @request = request
    end

    def run
      @client.send("PONG")
    end

    def >>(worker)
      worker << self
    end
  end
end
