module Jobs
  JOBS = {
    "PING" => Ping,
    "SEND" => Send
  }

  def self.factory(client, message, server)
    command = message.split.first.upcase
    klass = JOBS[command]

    if klass
      klass.new(client, message, server)
    end
  end
end
