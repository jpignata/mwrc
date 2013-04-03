module Jobs
  def self.factory(data, server)
    case data[0].split.first
    when "PING"
      Jobs::Ping.new(data, server)
    when "SEND"
      Jobs::Send.new(data, server)
    end
  end
end
