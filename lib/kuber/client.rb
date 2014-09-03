require 'json'
require 'rest-client'
require 'active_support/inflector'

module Kuber
  class Client
    def initialize
      Kuber.configuration ||= Kuber::Configuration.new
      @cl = RestClient::Resource.new(Kuber.configuration.url,
                                     :user => Kuber.configuration.username,
                                     :password => Kuber.configuration.password,
                                     :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
    end

    def send_request(method, path, body=nil)
      args = [method]
      args << body.to_json if body
      process_response @cl[path].send(*args)
    end

    def process_response(response)
      JSON.parse(response).recursively_symbolize_keys!
    end

    ['pod', 'service', 'replicationController'].each do |entity|
      define_method "list_#{entity.underscore.pluralize}" do
        response = send_request :get, entity.pluralize
        response[:items]
      end

      define_method "create_#{entity.underscore}" do |config|
        send_request :post, entity.pluralize, config
      end

      define_method "update_#{entity.underscore}" do |config|
        send_request :put, entity.pluralize, config
      end

      define_method "delete_#{entity.underscore}" do |id|
        send_request :delete, "#{entity.pluralize}/#{id}"
      end
    end
  end
end
