module Jobs
  JOBS = {
    "PING" => Ping,
    "SEND" => Send
  }

  def self.factory(data, server)
    command = data[0].split.first.upcase
    klass = JOBS[command]

    if klass
      klass.new(data, server)
    end
  end
end
