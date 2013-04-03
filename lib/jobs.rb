module Jobs
  JOBS = {
    "PING" => Ping,
    "SEND" => Send
  }

  def self.factory(client, request)
    klass = JOBS[request.command]

    if klass
      klass.new(client, request)
    end
  end
end
