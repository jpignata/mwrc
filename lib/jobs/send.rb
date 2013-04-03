module Jobs
  class Send
    def initialize(client, request)
      @client = client
      @request = request
    end

    def run
      PushNotification.new(registration_id, alert).deliver
    end

    def >>(worker)
      worker << self
    end

    private

    def registration_id
      @request.parameters[0]
    end

    def alert
      @request.parameters[1]
    end
  end
end
