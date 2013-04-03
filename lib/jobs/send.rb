module Jobs
  class Send < Job
    def run
      PushNotification.new(registration_id, alert).deliver
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
