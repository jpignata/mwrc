module Jobs
  class Send
    def self.client
      @client ||= HTTPClient.new
    end

    def initialize(client, message)
      @client = client
      @message = message
    end

    def run
      @message[5..-1].match(/([a-zA-Z0-9_\-]*) "([^"]*)/)

      json = JSON.generate({
        "registration_ids" => [$1],
        "data" => { "alert" => $2 }
      })

      self.class.client.post("https://android.googleapis.com/gcm/send", json, {
        "Authorization" => "key=AIzaSyCABSTd47XeIH",
        "Content-Type" => "application/json"
      })
    end
  end
end
