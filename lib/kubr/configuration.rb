module Kubr
  class Configuration

    attr_accessor :url, :username, :password, :token

    def initialize
      @url = ''
      @username = ''
      @password = ''
      @token = ''
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end
end
