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
    @server = UDPServer.new
  end

  def start
    @worker.spawn(10)
    @server.bind(6889)
    loop { process_request }
  end

  private

  def process_request
    data = @server.receive
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
