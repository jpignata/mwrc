require "bundler"
Bundler.setup

require "json"
require "thread"
require "httpclient"
require "socket"

require "worker"
require "udp_server"
require "jobs/ping"
require "jobs/send"

class PushDaemon
  def initialize
    @worker = Worker.new
    @server = UDPServer.new(self)
  end

  def start
    @worker.spawn(10)
    @server.listen(6889)
  end

  def call(data)
    case data[0].split.first
    when "PING"
      Jobs::Ping.new(data, @server).run
    when "SEND"
      json = Jobs::Send.new(data, @server).run
      @worker << json
    end
  end
end
