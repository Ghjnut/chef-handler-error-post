# Chef handler JSON poster
#
# Author:: Jake Pelletier
# Copyright:: Copyright 2012 Joe Miller
# License:: MIT License
#
require 'net/http'

class Chef
  class Handler
    class ErrorPost < Chef::Handler
      attr_reader :config
      def initialize(config={})
        @config = config
        #@config[:path] ||= "/var/chef/reports"
        @config[:host] ||= "127.0.0.1"
        @config[:port] ||= "5000"
        @config[:url_path] ||= "/"
        @config
      end
      def report
        if run_status.failed?
          Chef::Log.info("Creating JSON exception report")
          json_data = Chef::JSONCompat.to_json(data)
          begin
            post_report(json_data, config[:host], config[:port], config[:url_path])
          rescue Errno::ECONNREFUSED => msg
            Chef::Log.error("URL: #{config[:host]}:#{config[:port]} Messsage: #{msg}")
          end
        end
      end
      def post_report(json_data, host, port, url_path)
        req = Net::HTTP::Post.new(url_path, initheader = {'Content-Type' =>'application/json'})
        req.body = json_data
        response = Net::HTTP.new(host, port).start { |http| http.request(req) }
        Chef::Log.debug("Response #{response.code} #{response.message}: #{response.body}")
      end
    end
  end
end
