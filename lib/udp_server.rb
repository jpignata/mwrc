class UDPServer
  Data = Struct.new(:message, :sockaddr)

  def initialize(app)
    @app = app
    @socket = UDPSocket.new
  end

  def listen(port)
    @socket.bind("0.0.0.0", port)

    loop { @app.call(receive) }
  end

  def receive
    @socket.recvfrom(4096)
  end

  def send(message, address, port)
    @socket.send(message, 0, address, port)
  end
end
