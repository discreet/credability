module Outputs

  $report.each do |k,v|
    v.each do |k,v|
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
      puts
      puts "ID: #{k}"
      puts "State: #{v[:state]}"
      puts "Type: #{v[:type]}"
      puts "Launch Time: #{v[:launch_time]}"
      puts "Running Time: #{v[:running_time]}"
      puts "Subnet: #{v[:subnet]}"
      puts "Private IP: #{v[:private_ip]}"
      puts "Private DNS: #{v[:private_dns]}"

      if !v[:public_ip].nil?
        puts "Public IP: #{v[:public_ip]}"
      end

      if !v[:public_dns].nil?
        puts "Public DNS: #{v[:public_dns]}"
      end

      v[:security_group].each do |k,v|
        puts "Security Group #{k}: #{v}"
      end

      puts "Key: #{v[:key]}"
      puts "Availability Zone: #{v[:availability_zone]}"

      if !v[:iam].nil?
        v[:iam].each do |k,v|
          key = 'Profile ARN' if k == :profile_arn
	  key = 'Profile ID' if k == :profile_id
	  puts "IAM #{key}: #{v}"
        end
      end

      puts "Tenancy: #{v[:tenancy]}"
      puts "Monitoring: #{v[:monitoring]}"
      puts "VPC: #{v[:vpc]}"
      puts "Architecture: #{v[:architecture]}"
      puts "Virtualization: #{v[:virtualization]}"
      tags = v[:tags].map { |k,v| "#{k} => #{v}" if !v.empty? }.join(',').gsub(',', ', ')
      puts "Tags: #{tags}" if !tags.empty?
      puts
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    end
  end

end

