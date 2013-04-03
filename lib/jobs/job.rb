module Jobs
  class Job
    def initialize(client, request)
      @client = client
      @request = request
    end

    def >>(worker)
      worker << self
    end
  end
end
