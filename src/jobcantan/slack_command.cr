require "http/client"
require "json"

module Jobcantan
  class SlackCommand
    COMMAND = "/jobcan_touch"

    def execute(config : Config, message : String?, command : String = COMMAND) : String
      client = HTTP::Client.new("slack.com", tls: true)

      response = client.post("/api/chat.command", form: {
        token:   config.slack_token,
        channel: config.slack_channel_id,
        command: command,
        text:    "#{message || config.default_message}",
      })

      "Response. status_code: #{response.status_code} body: #{JSON.parse(response.body)}"
    rescue ex : Socket::Addrinfo::Error
      "Network Error. Try again after a while. (#{ex.message})"
    end
  end
end
