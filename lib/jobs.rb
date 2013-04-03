module Jobs
  JOBS = {
    "PING" => Ping,
    "SEND" => Send
  }

  JOBS.default = NullJob

  def self.factory(client, request)
    JOBS[request.command].new(client, request)
  end
end
