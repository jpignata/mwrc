class TestDaemon
  def initialize(port)
    @port = port
    @socket = UDPSocket.new
  end

  def start
    Thread.new { PushDaemon.new.start } unless ready?
  end

  def ready?
    system("lsof -p #{$PID} | grep -q 6889")
  end

  def last_response
    response, _ = @socket.recvfrom_nonblock(1024)
    response
  end

  def send(message)
    @socket.send(message, 0, "127.0.0.1", @port)
  end
end
