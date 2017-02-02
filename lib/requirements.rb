require 'yaml'

config = YAML::load_file(File.expand_path("../../config/config.yaml", __FILE__))

if !config['GemPath'].nil?
  Gem.paths = {
    'GEM_PATH' => config['GemPath']
  }
end

require 'aws-sdk'
require 'optparse'
require 'rcredstash'
require 'uri'
require 'json'
require 'erb'

require_relative 'core/options'
require_relative 'core/list'
require_relative 'core/validate'
require_relative 'core/rcredstash'

require_relative 'outputs/reports'

include Core
include Outputs

