module Outputs

  $report.each do |k,v|
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts
    puts "Name: #{k}"
    puts "Type: #{v[:type]}"
    puts "Scheme: #{v[:scheme]}"
    puts "Creation Date: #{v[:creation_date]}"
    puts "DNS Name: #{v[:dns_name]}"
    puts "Availability Zones: #{v[:availability_zones][:name].join(',').gsub(',', ', ')}"
    puts "Subnets: #{v[:availability_zones][:subnet_id].join(',').gsub(',', ', ')}"
    puts "Security Groups: #{v[:security_group].join(',').gsub(',', ', ')}"
    puts "Logging: #{v[:logging][:access_log]}"
    puts "S3 Location: #{v[:logging][:s3_log_location]}"
    puts "Log Prefix: #{v[:logging][:s3_log_prefix]}"

    tags = v[:tags].map { |k,v| "#{k} => #{v}" if !v.empty? }.join(',').gsub(',',', ')
    puts "Tags: #{tags}" if !tags.empty?
    puts
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  end

end

