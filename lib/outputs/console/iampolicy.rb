module Outputs

  $report.each do |k,v|
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts
    puts "Name: #{k}"
    puts "ARN: #{v[:arn]}"
    puts "Version: #{v[:version]}"
    puts "Default Version: #{v[:default_version]}"
    puts "Creation Date: #{v[:creation_date]}"
    puts "Updated Date: #{v[:updated_date]}"
    puts "Attachment Count: #{v[:attached_count]}"
    puts "Policy Document: #{v[:policy_document]}"
    puts
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  end

end

