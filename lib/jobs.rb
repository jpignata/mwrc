module Jobs
  JOBS = {
    "PING" => Ping,
    "SEND" => Send
  }

  def self.factory(client, message)
    command = message.split.first.upcase
    klass = JOBS[command]

    if klass
      klass.new(client, message)
    end
  end
end
