module Reports

  def get_route53zones()
    list = $client.list_hosted_zones({})

    if list.hosted_zones.empty?
      puts 'No Route53 Zones Available'
      $noreport = 'No Route53 Zones Available'
      exit
    else
      $report = Hash.new

      list.hosted_zones.map { |i| i['id'] }.each do |id|
        data = $client.get_hosted_zone(
	  {
	    id: id
	  }
	)
	name = data.hosted_zone.name

	$report[name] = Hash.new
	$report[name][:private_zone] = data.hosted_zone.config.private_zone
	$report[name][:resource_count] = data.hosted_zone.resource_record_set_count
      end
    end
  end

end

