require "option_parser"
require "file_utils"
require "./jobcantan/*"

module Jobcantan
  class CLI
    class Options
      property show_version : Bool = false
      property show_help : Bool = false
      property show_config : Bool = false
      property init : Bool = false
      property config_file : String = File.expand_path(".config/jobcantan.yml", ENV["HOME"])
      property message : String? = nil
    end

    def initialize(@io : IO = STDOUT)
      @options = Options.new
    end

    def parse_option(argv) : Options
      parser = OptionParser.new

      parser.on("-v", "--version", "Show version.") do
        @options.show_version = true
      end
      parser.on("-h", "--help", "Show help.") do
        @options.show_help = true
      end
      parser.on("--init", "Initialize configuration.") do
        @options.init = true
      end
      parser.on("--show-config", "Show config.") do
        @options.show_config = true
      end
      parser.on("-c CONFIG_FILE", "--config CONFIG_FILE", "Specify config file.") do |config_file|
        @options.config_file = config_file
      end
      parser.unknown_args do |unknown_args|
        @options.message = unknown_args.join(" ") unless unknown_args.empty?
      end

      parser.parse(argv)

      @options
    rescue ex : OptionParser::MissingOption
      @options.show_help = true

      @options
    end

    def run(argv = ARGV)
      options = parse_option(argv)

      if options.show_help
        @io.puts banner
        return
      end

      if options.show_version
        @io.puts version
        return
      end

      if options.init
        Dir.mkdir_p(File.dirname(options.config_file))
        File.write(options.config_file, init_config)
        @io.puts "config_file created. Please edit #{File.expand_path(options.config_file)}"
        return
      end

      unless File.exists?(options.config_file)
        @io.puts "config_file not found. (#{File.expand_path(options.config_file)})"
        return
      end

      config_yaml_string = File.read(options.config_file)

      if options.show_config
        @io.puts "#{config_yaml_string}\n (in #{File.expand_path(options.config_file)})"
        return
      end

      begin
        config = Config.from_yaml(config_yaml_string)
      rescue ex : YAML::ParseException
        @io.puts "Invalid config in #{File.expand_path(options.config_file)}. (#{ex.message})"
        return
      end

      result = SlackCommand.new.execute(config, options.message)
      @io.puts result
    end

    private def banner : String
      <<-BANNER

      jobcantan - CLI for punching in/out in Jobcan via Slack command.

      Usage: jobcantan [options] message
        -c, --config CONFIG_FILE
        -h, --help
        -v, --version
            --show-config
            --init

      BANNER
    end

    private def version : String
      "jobcantan #{Jobcantan::VERSION}"
    end

    private def init_config : String
      <<-CONFIG
      slack_token: xoxp-<SLACK-LEGACY-TOKEN> # <required>
      slack_channel_id: C0XXXXX # <required>
      default_message: Hello World # <optional>
      CONFIG
    end
  end
end
