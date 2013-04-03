module Jobs
  class Ping
    def initialize(client, message)
      @client = client
      @message = message
    end

    def run
      @client.send("PONG")
    end
  end
end
