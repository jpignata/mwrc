module Jobs
  class Ping
    def initialize(data, server)
      @data = data
      @server = server
    end

    def run
      @server.send("PONG", @data[1][3], @data[1][1])
    end
  end
end
