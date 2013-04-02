module AsyncHelper
  MAX_WAIT = 1
  RETRY_INTERVAL = 0.025

  def eventually
    error = Timeout::Error

    Timeout.timeout(MAX_WAIT) do
      begin
        yield
      rescue => error
        sleep RETRY_INTERVAL
        retry
      end
    end

  rescue Timeout::Error
    raise error
  end
end

RSpec.configuration.include AsyncHelper
