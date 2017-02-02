module Outputs

  def give_yaml(report)

    case report
    when 'DynamodbTables'
      require_relative '../reports/dynamodb'

      get_tables()
      puts $report.to_yaml
    when 'KmsKeys'
      require_relative '../reports/kms'

      get_keys()
      puts $report.to_yaml
    when 'Ec2Instances'
      require_relative '../reports/ec2instance'

      get_instances()
      puts $report.to_yaml
    when 'IamPolicies'
      require_relative '../reports/iampolicy'

      get_policies()
      puts $report.to_yaml
    when 'IamRoles'
      require_relative '../reports/iamrole'

      get_roles()
      puts $report.to_yaml
    when 'LoadBalancers'
      require_relative '../reports/loadbalancer'

      get_loadbalancers()
      puts $report.to_yaml
    when 'ReservedInstances'
      require_relative '../reports/reservedinstance'

      get_reservedinstances()
      puts $report.to_yaml
    when 'Route53Zones'
      require_relative '../reports/route53'

      get_route53zones()
      puts $report.to_yaml
    when 'S3Buckets'
      require_relative '../reports/s3bucket'

      get_s3buckets()
      puts $report.to_yaml
    end
  end

end
