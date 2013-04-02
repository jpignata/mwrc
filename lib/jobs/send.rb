module Jobs
  class Send
    def initialize(data, server)
      @data = data
      @server = server
    end

    def run
      @data[0][5..-1].match(/([a-zA-Z0-9_\-]*) "([^"]*)/)

      JSON.generate({
        "registration_ids" => [$1],
        "data" => { "alert" => $2 }
      })
    end
  end
end
