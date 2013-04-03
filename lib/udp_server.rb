class UDPServer
  Data = Struct.new(:message, :sockaddr)

  def initialize(app)
    @app = app
    @socket = UDPSocket.new
  end

  def listen(port)
    @socket.bind("0.0.0.0", port)

    loop do
      message, sockaddr = @socket.recvfrom(4096)
      client = Client.new(sockaddr)

      @app.call(client, message)
    end
  end

  def send(message, address, port)
    @socket.send(message, 0, address, port)
  end
end
