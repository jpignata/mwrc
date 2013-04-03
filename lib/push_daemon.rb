require "bundler"
Bundler.setup

require "json"
require "thread"
require "httpclient"
require "socket"

require "worker"
require "client"
require "udp_server"
require "jobs/ping"
require "jobs/send"
require "jobs"
require "push_notification"

class PushDaemon
  def initialize
    @worker = Worker.new
    @server = UDPServer.new(self)
  end

  def start
    @worker.spawn(10)
    @server.listen(6889)
  end

  def call(client, message)
    job = Jobs.factory(client, message)

    if job
      @worker << job
    end
  end
end
