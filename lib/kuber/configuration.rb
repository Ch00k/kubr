module Kuber
  class Configuration

    attr_accessor :url, :username, :password

    def initialize
      @url = ''
      @username = ''
      @password = ''
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
