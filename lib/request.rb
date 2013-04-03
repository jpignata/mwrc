class Request
  def initialize(message)
    @tokens = Shellwords.split(message)
  end

  def command
    @tokens[0].to_s.upcase
  end

  def parameters
    Array(@tokens[1..-1])
  end
end
