require "yaml"

module Jobcantan
  class Config
    YAML.mapping(
      slack_token: String,
      slack_channel_id: String,
      default_message: String?,
    )
  end
end
