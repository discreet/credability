config = YAML::load_file(File.expand_path("../config/config.yaml", __FILE__))

Gem.paths = {
  'GEM_PATH' => config['GemPath']
}

require 'aws-sdk'
require 'optparse'
require 'rcredstash'
require 'uri'
require 'json'
require 'yaml'
require 'erb'

require_relative 'audit/options'
require_relative 'audit/reports/list'
require_relative 'audit/validate'

require_relative 'audit/rcredstash'
require_relative 'audit/filter'

require_relative 'audit/reports/creds'

require_relative 'audit/reports/route53zone'
require_relative 'audit/reports/s3buckets'
require_relative 'audit/reports/kmskeys'
require_relative 'audit/reports/iampolicies'
require_relative 'audit/reports/iamroles'
require_relative 'audit/reports/dynamodb'
require_relative 'audit/reports/elasticlbs'
require_relative 'audit/reports/reservedinstances'
require_relative 'audit/reports/ec2instances'

module Audit
end
