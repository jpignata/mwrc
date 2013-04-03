module Jobs
  class Ping
    def initialize(client, message, server)
      @client = client
      @message = message
      @server = server
    end

    def run
      @server.send("PONG", @client.address, @client.port)
    end
  end
end
