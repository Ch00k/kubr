require 'json'
require 'rest-client'
require 'active_support/inflector'

module Kubr
  class Client
    def initialize
      Kubr.configuration ||= Kubr::Configuration.new
      opts = {:verify_ssl => OpenSSL::SSL::VERIFY_NONE}
      if Kubr.configuration.token
        opts[:headers] = {:authorization => "Bearer #{Kubr.configuration.token}"}
      else
        opts.merge({ :user => Kubr.configuration.username,
                     :password => Kubr.configuration.password })
      end

      @cl = RestClient::Resource.new(Kubr.configuration.url,
                                     opts)
    end

    def send_request(method, path, body=nil, labels=nil)
      args = [method]
      args << body.to_json if body
      path += parse_labels_hash(labels) if labels
      process_response @cl[path].send(*args)
    rescue RestClient::UnprocessableEntity, RestClient::InternalServerError => e
      process_response e.response
    end

    def process_response(response)
      JSON.parse(response).recursively_symbolize_keys!
    end

    def parse_labels_hash(labels)
      labels_string = '?labels='
      labels.each { |key, value| labels_string << "#{key}=#{value}," }
      labels_string
    end

    ['minion', 'pod', 'service', 'replicationController'].each do |entity|
      define_method "list_#{entity.underscore.pluralize}" do |labels=nil|
        send_request :get, entity.pluralize, nil, labels
      end

      define_method "get_#{entity.underscore}" do |id|
        send_request :get, "#{entity.pluralize}/#{id}"
      end

      unless entity == 'minion'
        define_method "create_#{entity.underscore}" do |config|
          send_request :post, entity.pluralize, config
        end

        define_method "update_#{entity.underscore}" do |id, config|
          send_request :put, "#{entity.pluralize}/#{id}", config
        end

        define_method "delete_#{entity.underscore}" do |id|
          send_request :delete, "#{entity.pluralize}/#{id}"
        end
      end
    end
  end
end
