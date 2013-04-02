class UDPServer
  def initialize(socket = UDPSocket.new)
    @socket = socket
  end

  def bind(port)
    @socket.bind("0.0.0.0", port)
  end

  def receive
    @socket.recvfrom(4096)
  end

  def send(message, address, port)
    @socket.send(message, 0, address, port)
  end
end
