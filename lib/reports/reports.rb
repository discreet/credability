module Reports

  case $options.report
  when 'DynamodbTables'
    require_relative 'dynamodb'
  when 'KmsKeys'
    require_relative 'kms'
  when 'Ec2Instances'
    require_relative 'ec2instance'
  when 'IamPolicies'
    require_relative 'iampolicy'
  when 'IamRoles'
    require_relative 'iamrole'
  when 'S3Buckets'
    require_relative 's3bucket'
  when 'Route53Zones'
    require_relative 'route53'
  when 'LoadBalancers'
    require_relative 'loadbalancer'
  when 'ReservedInstances'
    require_relative 'reservedinstance'
  end

end

