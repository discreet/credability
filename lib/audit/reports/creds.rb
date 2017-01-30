module Audit
  class Creds

    tables = YAML::load_file(File.expand_path("../../../../config/config.yaml", __FILE__))

    if tables['ProdTables'].include?($options.table)
      access_key = 'reports.access.prod'
      secret_key = 'reports.secret.prod'
    elsif tables['DevTables'].include?($options.table)
      access_key = 'reports.access.dev'
      secret_key = 'reports.secret.dev'
    end

    if !$options.region.nil? and !$options.table.nil? and !$options.report.nil?
      access_key = CredStash.get(access_key)
      secret_key = CredStash.get(secret_key)
    end

    case $options.report
    when 'KmsKeys'
      $client = Aws::KMS::Client.new(
        {
          access_key_id: access_key,
          secret_access_key: secret_key,
          region: $options.region
        }
      )
    when 'DynamodbTables'
      $client = Aws::DynamoDB::Client.new(
        {
          access_key_id: access_key,
          secret_access_key: secret_key,
          region: $options.region
        }
      )
    when 'IamPolicies', 'IamRoles'
      $client = Aws::IAM::Client.new(
        {
          access_key_id: access_key,
          secret_access_key: secret_key,
          region: $options.region
        }
      )
    when 'S3Buckets'
      $client = Aws::S3::Client.new(
        {
          access_key_id: access_key,
          secret_access_key: secret_key,
          region: $options.region
        }
      )
    when 'Route53Zones'
      $client = Aws::Route53::Client.new(
        {
          access_key_id: access_key,
          secret_access_key: secret_key,
          region: $options.region
        }
      )
    when 'ElasticLBs'
      $elbclient = Aws::ElasticLoadBalancing::Client.new(
        {
          access_key_id: access_key,
          secret_access_key: secret_key,
          region: $options.region
        }
      )
      $albclient = Aws::ElasticLoadBalancingV2::Client.new(
        {
          access_key_id: access_key,
          secret_access_key: secret_key,
          region: $options.region
        }
      )
    when 'ReservedInstances', 'Ec2Instances'
      $client = Aws::EC2::Client.new(
        {
	  access_key_id: access_key,
	  secret_access_key: secret_key,
	  region: $options.region
	}
      )
    end

  end
end
