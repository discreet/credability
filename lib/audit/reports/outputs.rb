module Audit
  class Outputs

    case $options.report
    when 'DynamodbTables'
      $report.each do |k,v|
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        puts
        puts "Table Name: #{k}"
        puts "Table ARN: #{v[:arn]}"
        puts "Creation Date: #{v[:create_date]}"
        puts "Table Items: #{v[:items]}"
        puts "Table Status: #{v[:status]}"
        puts
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
      end
    when 'IamPolicies'
      $report.each do |k,v|
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        puts
        puts "Policy Name: #{k}"
        puts "Policy ARN: #{v[:arn]}"
        puts "Policy Version: #{v[:version]}"
        if v[:version] != v[:default_version]
          puts "Policy Default Version: #{v[:default_version]}"
        end
        puts "Policy Creation Date: #{v[:creation_date]}"
        puts "Policy Update Date: #{v[:update_date]}"
        puts "Policy Attachment Count: #{v[:attach_count]}"
        puts "Policy Document: #{v[:policy_document]}"
        puts
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
      end
    when 'IamRoles'
      $report.each do |k,v|
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        puts
        puts "Role: #{k}"
        puts "Role ARN: #{v[:arn]}"
        puts "Role Creation Date: #{v[:creation_date]}"
        if !v[:policies][:policy_name].empty? and !v[:policies][:policy_arn].empty?
          puts 'Attached Policy Names:'
	  puts v[:policies][:policy_name]
	  puts 'Attached Policy ARNs:'
	  puts v[:policies][:policy_arn]
        else
          puts "No Attached Policies"
        end
        puts
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
      end
    when 'KmsKeys'
      $report.each do |k,v|
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        puts
        puts "Key Name: #{k}"
        puts "Key ARN: #{v[:arn]}"
        puts "Key State: #{v[:state]}"
        puts
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
      end
    when 'Route53Zones'
      $report.each do |k,v|
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        puts
        puts "Route53 Zone Name: #{k}"
        puts "Record Count: #{v[:resource_count]}"
        puts "Private Zone: #{v[:private_zone]}"
        puts
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
      end
    when 'S3Buckets'
      $report.each do |k,v|
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        puts
        puts "Bucket Names: #{k}"
        puts "Creation Date: #{v[:creation_date]}"
        puts "Logging Enabled: #{v[:logging]}"
        puts "Log Target: #{v[:target]}"
        puts
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
      end
    when 'ElasticLBs'
      $report.each do |k,v|
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        puts
        puts "Load Balancer Name: #{k}"
        puts "Load Balancer Type: #{v[:type]}"
        puts "Load Balancer Scheme: #{v[:scheme]}"
        puts "Load Balancer Creation: #{v[:created_time]}"
        puts "Load Balancer DNS Name: #{v[:dns_name]}"
        puts "Load Balancer AZs: #{v[:availability_zones][:name].join(',').gsub(/,/, ', ')}"
        puts "Load Balancer Subnets: #{v[:availability_zones][:subnet_id].join(',').gsub(/,/, ', ')}"
        puts "Load Balancer Security Groups: #{v[:security_group].join(',').gsub(/,/, ', ')}"
        puts "Load Balancer Logging: #{v[:logging][:access_log]}"
        puts "Load Balancer S3 Location: #{v[:logging][:s3_log_location]}"
        puts "Load Balancer Log Prefix: #{v[:logging][:s3_log_prefix]}"
        puts
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
      end
    when 'Ec2Instances'
      $report.each do |k,v|
        v.each do |k,v|
          puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
	  puts
	  puts "Instance ID: #{k}"
	  puts "Instance State: #{v[:state]}"
	  puts "Instance Type: #{v[:type]}"
	  puts "Instance Launch Time: #{v[:launch_time]}"
	  puts "Instance Subnet: #{v[:subnet]}"
	  puts "Instance Private IP: #{v[:private_ip]}"
	  puts "Instance Private DNS: #{v[:private_dns]}"
	  if !v[:public_ip].nil?
	    puts "Instance Public IP: #{v[:public_ip]}"
	  end
	  if !v[:public_dns].nil?
	    puts "Instance Public DNS: #{v[:public_dns]}"
	  end
          v[:security_group].each do |k,v|
	    puts "Instance Security Group #{k}: #{v}"
	  end
	  puts "Instance Key: #{v[:key_name]}"
	  puts "Instance AZ: #{v[:availability_zone]}"
	  if !v[:iam].nil?
	    v[:iam].each do |k,v|
	      key = 'Profile ARN' if k == :profile_arn
	      key = 'Profile ID' if k == :profile_id
	      puts "Instance IAM #{key}: #{v}"
	    end
	  end
	  puts "Instance Tenancy: #{v[:tenancy]}"
	  puts "Instance Monitoring: #{v[:monitoring]}"
	  puts "Instance VPC: #{v[:vpc]}"
	  puts "Instance Arch: #{v[:architecture]}"
	  puts "Instance Virtualization: #{v[:virtualization]}"
	  tags = v[:tags].map{ |k,v| "#{k}=>#{v}" if !v.empty? }.join(',').gsub(',', ', ')
	  puts "Instance Tags: #{tags}" if !tags.empty?
	  puts
	  puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
	end
      end
    when 'ReservedInstances'
      $report.each do |k,v|
        v.each do |k,v|
	  puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
          puts
          puts "Instance ID: #{k}"
	  puts "Instance Type: #{v[:type]}"
	  puts "Instance Count: #{v[:count]}"
	  puts "Instance State: #{v[:state]}"
	  if !v[:availability_zone].nil?
	    puts "Instance AZs: #{v[:availability_zone]}"
	  end
	  puts "Instance Scope: #{v[:scope]}"
	  puts "Instance Tenancy: #{v[:tenancy]}"
	  puts "Instance Offering Type: #{v[:offering_type]}"
	  puts "Instance Offering Class: #{v[:offering_class]}"
	  puts "Instance Product OS: #{v[:product_os]}"
	  puts "Instance Start Time: #{v[:start]}"
	  puts "Instance End Time: #{v[:end]}"
	  puts "Instance Duration: #{Time.at(v[:duration]).utc.strftime("%Hhr%Mmin%Ssec")}"
	  puts "Instance Currency Code: #{v[:currency]}"
	  puts "Instance Usage Price: #{v[:usage_price]}"
	  puts "Instance Fixed Price: #{v[:fixed_price]}"
	  puts "Recurring Charge Frequency: #{v[:recurring_charges].select { |k,v| k == :frequency }.values.first}"
	  puts "Recurring Charge Amount Amount: #{v[:recurring_charges].select { |k,v| k == :amount }.values.first}"
	  if !v[:tags].empty?
	    puts "Instance Tags: #{v[:tags]}"
	  end
	  puts
	  puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        end
      end
    end

  end
end
