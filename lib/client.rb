class Client
  def initialize(sockaddr, server)
    @addrinfo = Addrinfo.new(sockaddr)
    @server = server
  end

  def send(message)
    @server.send(message, address, port)
  end

  def address
    @addrinfo.ip_address
  end

  def port
    @addrinfo.ip_port
  end
end
