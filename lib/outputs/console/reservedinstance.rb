module Outputs

  $report.each do |k,v|
    v.each do |k,v|
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
      puts
      puts "ID: #{k}"
      puts "Type: #{v[:type]}"
      puts "Count: #{v[:count]}"
      puts "State: #{v[:state]}"

      if !v[:availability_zone].nil?
        puts "Availability Zones: #{v[:availability_zone]}"
      end

      puts "Scope: #{v[:scope]}"
      puts "Tenancy: #{v[:tenancy]}"
      puts "Offering Type: #{v[:offering_type]}"
      puts "Offering Class: #{v[:offering_class]}"
      puts "Product OS: #{v[:product_os]}"
      puts "Start Time: #{v[:start]}"
      puts "End Time: #{v[:end]}"
      puts "Duration: #{v[:duration]}"
      puts "Currency: #{v[:currency]}"
      puts "Usage Price: #{v[:usage_price]}"
      puts "Fixed Price: #{v[:fixed_price]}"
      puts "Recurring Charge Frequency: #{v[:recurring_charges].select { |k,v| k == :frequency }.values.first}"
      puts "Recurring Charge Amount: #{v[:recurring_charges].select { |k,v| k == :amount }.values.first}"

      if !v[:tags].empty?
        puts "Tags: #{v[:tags]}"
      end

      puts
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    end
  end

end

