module Outputs

  $report.each do |k,v|
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts
    puts "Name: #{k}"
    puts "ARN: #{v[:arn]}"
    puts "State: #{v[:state]}"
    puts
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  end

end

