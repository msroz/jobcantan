require "./spec_helper"

describe Jobcantan::CLI do
  describe "#run" do
    describe "with '-v'" do
      it "prints version" do
        io = IO::Memory.new
        Jobcantan::CLI.new(io).run(["-v"])

        io.to_s.should eq "jobcantan #{Jobcantan::VERSION}\n"
      end
    end

    describe "with '-h'" do
      it "prints help" do
        io = IO::Memory.new
        Jobcantan::CLI.new(io).run(["-h"])

        io.to_s.should eq <<-HELP

        jobcantan - CLI for punching in/out in Jobcan via Slack command.

        Usage: jobcantan [options] message
          -c, --config CONFIG_FILE
          -h, --help
          -v, --version
              --show-config
              --init

        HELP
      end
    end

    describe "with wrong config file " do
      it "prints error message" do
        io = IO::Memory.new
        Jobcantan::CLI.new(io).run(["-c", "wrong_config_file"])

        io.to_s.should contain("config_file not found.")
      end
    end

    describe "with wrong format config" do
      it "prints error message" do
        io = IO::Memory.new
        Jobcantan::CLI.new(io).run(["-c", "./spec/config.json"])

        io.to_s.should contain("Invalid config in")
      end
    end

    describe "without config value" do
      it "prints help" do
        io = IO::Memory.new
        Jobcantan::CLI.new(io).run(["-c"])

        io.to_s.should eq <<-HELP

        jobcantan - CLI for punching in/out in Jobcan via Slack command.

        Usage: jobcantan [options] message
          -c, --config CONFIG_FILE
          -h, --help
          -v, --version
              --show-config
              --init

        HELP
      end
    end
  end
end
