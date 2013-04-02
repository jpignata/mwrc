require "bundler"
Bundler.setup

require "json"
require "thread"
require "httpclient"
require "socket"

require "worker"
require "udp_server"

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
      @server.send("PONG", data[1][3], data[1][1])
    when "SEND"
      data[0][5..-1].match(/([a-zA-Z0-9_\-]*) "([^"]*)/)
      json = JSON.generate({
        "registration_ids" => [$1],
        "data" => { "alert" => $2 }
      })
      @worker << json
    end
  end
end
