module Jobs
  class Send
    def initialize(client, message)
      @client = client
      @message = message
    end

    def run
      @message[5..-1].match(/([a-zA-Z0-9_\-]*) "([^"]*)/)
      PushNotification.new($1, $2).deliver
    end
  end
end
