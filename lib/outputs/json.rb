module Outputs

  def give_json(report)

    case report
    when 'DynamodbTables'
      require_relative '../reports/dynamodb'

      get_tables()
      puts JSON.generate($report)
    when 'KmsKeys'
      require_relative '../reports/kms'

      get_keys()
      puts JSON.generate($report)
    when 'Ec2Instances'
      require_relative '../reports/ec2instance'

      get_instances()
      puts JSON.generate($report)
    when 'IamPolicies'
      require_relative '../reports/iampolicy'

      get_policies()
      puts JSON.generate($report)
    when 'IamRoles'
      require_relative '../reports/iamrole'

      get_roles()
      puts JSON.generate($report)
    when 'LoadBalancers'
      require_relative '../reports/loadbalancer'

      get_loadbalancers()
      puts JSON.generate($report)
    when 'ReservedInstances'
      require_relative '../reports/reservedinstance'

      get_reservedinstances()
      puts JSON.generate($report)
    when 'Route53Zones'
      require_relative '../reports/route53'

      get_route53zones()
      puts JSON.generate($report)
    when 'S3Buckets'
      require_relative '../reports/s3bucket'

      get_s3buckets()
      puts JSON.generate($report)
    end
  end

end

