module Outputs

  $report.each do |k,v|
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts
    puts "Zone Name: #{k}"
    puts "Private: #{v[:private_zone]}"
    puts "Record Count: #{v[:resource_count]}"
    puts
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  end

end

