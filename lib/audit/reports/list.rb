module Audit
  class Reports

    $reports_available = [
      'KmsKeys',
      'DynamodbTables',
      'IamPolicies',
      'IamRoles',
      'S3Buckets',
      'Route53Zones',
      'ElasticLBs',
      'ReservedInstances',
      'Ec2Instances',
    ]

  end
end
