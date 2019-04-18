require "../spec_helper"

describe Jobcantan::Config do
  describe "full configuration" do
    it "returns all configuration." do
      config = Jobcantan::Config.from_yaml("slack_token: foo\nslack_channel_id: bar\ndefault_message: baz")

      config.slack_token.should eq("foo")
      config.slack_channel_id.should eq("bar")
      config.default_message.should eq("baz")
    end
  end

  describe "min configuration" do
    it "returns all configuration." do
      config = Jobcantan::Config.from_yaml("slack_token: foo\nslack_channel_id: bar")

      config.slack_token.should eq("foo")
      config.slack_channel_id.should eq("bar")
      config.default_message.should eq(nil)
    end
  end
end
