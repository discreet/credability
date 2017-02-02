module Core

  def get_creds(table, region)

    tables = YAML::load_file(File.expand_path("../../../config/config.yaml", __FILE__))

    if tables['ProdTables'].include?(table)
      access_key = 'reports.access.prod'
      secret_key = 'reports.secret.prod'
    elsif tables['DevTables'].include?(table)
      access_key = 'reports.access.prod'
      secret_key = 'reports.secret.prod'
    end

    @access_key = CredStash.get(access_key)
    @secret_key = CredStash.get(secret_key)
  end

  def auth(report, region)

    access_key = @access_key
    secret_key = @secret_key

    case report
    when 'KmsKeys'
      $client = Aws::KMS::Client.new(
	{
	  access_key_id: access_key,
	  secret_access_key: secret_key,
	  region: region
	}
      )
    when 'DynamodbTables'
      $client = Aws::DynamoDB::Client.new(
        {
	  access_key_id: access_key,
	  secret_access_key: secret_key,
	  region: region
	}
      )
    when 'IamPolicies', 'IamRoles'
      $client = Aws::IAM::Client.new(
        {
	  access_key_id: access_key,
	  secret_access_key: secret_key,
	  region: region
	}
      )
    when 'S3Buckets'
      $client = Aws::S3::Client.new(
        {
	  access_key_id: access_key,
	  secret_access_key: secret_key,
	  region: region
	}
      )
    when 'LoadBalancers'
      $elbclient = Aws::ElasticLoadBalancing::Client.new(
        {
	  access_key_id: access_key,
	  secret_access_key: secret_key,
	  region: region
	}
      )

      $albclient = Aws::ElasticLoadBalancingV2::Client.new(
        {
	  access_key_id: access_key,
	  secret_access_key: secret_key,
	  region: region
	}
      )
    when 'ReservedInstances', 'Ec2Instances'
      $client = Aws::EC2::Client.new(
        {
	  access_key_id: access_key,
	  secret_access_key: secret_key,
	  region: region
	}
      )
    end
  end

end

