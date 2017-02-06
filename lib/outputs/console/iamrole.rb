module Outputs

  $report.each do |k,v|
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts
    puts "Name: #{k}"
    puts "ARN: #{v[:arn]}"
    puts "Creation Date: #{v[:creation_date]}"

    if !v[:policies][:name].nil? and !v[:policies][:policy_arn].nil?
      puts 'Attached Policy Names:'
      puts v[:policies][:name]
      puts 'Attached Policy ARNs:'
      puts v[:policies][:arn]
    else
      puts 'No Attached Policies'
    end

    puts
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  end

end

