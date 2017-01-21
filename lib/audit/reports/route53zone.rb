module Audit
  class Route53Zones

    if $options.report == 'Route53Zones'
      route53_zones = $client.list_hosted_zones({})

      if route53_zones.hosted_zones.empty?
	puts 'No Zones Available'
      else
        $report = Hash.new

	zone_ids = route53_zones.hosted_zones.map{ |i| i['id'] }

        zone_ids.each do |zone_id|
          zone_data = $client.get_hosted_zone(
	    {
	      id: zone_id
	    }
	  )

	  $report[zone_name] = Hash.new
	  $report[zone_name][:private_zone] = zone_data.hosted_zone.config.private_zone
	  $report[zone_name][:resource_count] = zone_data.hosted_zone.resource_record_set_count
	end
      end
    end

  end
end
