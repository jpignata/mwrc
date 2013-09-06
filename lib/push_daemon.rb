require "bundler"
Bundler.setup

require "json"
require "thread"
require "httpclient"
require "socket"
require "shellwords"

require "worker"
require "client"
require "request"
require "udp_server"
require "jobs/job"
require "jobs/ping"
require "jobs/send"
require "jobs/null_job"
require "jobs"
require "push_notification"

class PushDaemon
  def initialize(params = {})
    params = defaults.merge(params)
    @worker = params[:worker]
    @server = params[:server_class].new(self)
  end

  def start
    @worker.spawn(10)
    @server.listen(6889)
  end

  def call(client, message)
    request = Request.new(message)
    job = Jobs.factory(client, request)

    job >> @worker
  end

  private

  def defaults
    {
      worker: Worker.new,
      server_class: UDPServer
    }
  end
end
