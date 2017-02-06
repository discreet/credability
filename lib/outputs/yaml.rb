module Outputs

  def give_yaml(report)

    case report
    when 'DynamodbTables'
      require_relative '../reports/dynamodb'
      get_tables()
    when 'KmsKeys'
      require_relative '../reports/kms'
      get_keys()
    when 'Ec2Instances'
      require_relative '../reports/ec2instance'
      get_instances()
    when 'IamPolicies'
      require_relative '../reports/iampolicy'
      get_policies()
    when 'IamRoles'
      require_relative '../reports/iamrole'
      get_roles()
    when 'LoadBalancers'
      require_relative '../reports/loadbalancer'
      get_loadbalancers()
    when 'ReservedInstances'
      require_relative '../reports/reservedinstance'
      get_reservedinstances()
    when 'Route53Zones'
      require_relative '../reports/route53'
      get_route53zones()
    when 'S3Buckets'
      require_relative '../reports/s3bucket'
      get_s3buckets()
    end
    puts $report.to_yaml
  end

end
