class Client
  def initialize(sockaddr)
    @addrinfo = Addrinfo.new(sockaddr)
  end

  def address
    @addrinfo.ip_address
  end

  def port
    @addrinfo.ip_port
  end
end
