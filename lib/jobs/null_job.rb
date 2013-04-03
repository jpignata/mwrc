module Jobs
  class NullJob
    def initialize(client, request)
    end

    def run
    end

    def >>(worker)
    end
  end
end
