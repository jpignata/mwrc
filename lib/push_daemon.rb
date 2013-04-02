require "bundler"
Bundler.setup

require "json"
require "thread"
require "httpclient"
require "socket"

require "worker"

class PushDaemon
  def initialize
    @worker = Worker.new
    @socket = UDPSocket.new
  end

  def start
    @worker.spawn(10)
    bind
    loop { process_request }
  end

  private

  def bind
    @socket.bind("0.0.0.0", 6889)
  end

  def process_request
    data = @socket.recvfrom(4096)
    case data[0].split.first
    when "PING"
      @socket.send("PONG", 0, data[1][3], data[1][1])
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
