module Outputs

  def give_console(report)

    case report
    when 'DynamodbTables'
      require_relative '../reports/dynamodb'
      get_tables()
      require_relative 'console/dynamodb'
    when 'KmsKeys'
      require_relative '../reports/kms'
      get_keys()
      require_relative 'console/kms'
    when 'Ec2Instances'
      require_relative '../reports/ec2instance'
      get_instances()
      require_relative 'console/ec2instance'
    when 'IamPolicies'
      require_relative '../reports/iampolicy'
      get_policies()
      require_relative 'console/iampolicy'
    when 'IamRoles'
      require_relative '../reports/iamrole'
      get_roles()
      require_relative 'console/iamrole'
    when 'S3Buckets'
      require_relative '../reports/s3bucket'
      get_s3buckets()
      require_relative 'console/s3bucket'
    when 'Route53Zones'
      require_relative '../reports/route53'
      get_route53zones()
      require_relative 'console/route53'
    when 'LoadBalancers'
      require_relative '../reports/loadbalancer'
      get_loadbalancers()
      require_relative 'console/loadbalancer'
    when 'ReservedInstances'
      require_relative '../reports/reservedinstance'
      get_reservedinstances()
      require_relative 'console/reservedinstance'
    end
  end

end

