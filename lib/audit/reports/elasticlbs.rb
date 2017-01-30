module Audit
  class ElasticLBs

    def get_loadbalancer(report, elbclient, albclient)
      report = $options.report
      elbclient = $elbclient
      albclient = $albclient

      if report == 'ElasticLBs'
        elasticlbs     = elbclient.describe_load_balancers({})
        applicationlbs = albclient.describe_load_balancers({})

        if applicationlbs.load_balancers.empty? or elasticlbs.load_balancer_descriptions.empty?
          puts 'No Load Balancers Available'
          $noreport = 'No Load Balancers Available'
        else
          $report = Hash.new

          applicationlbs.load_balancers.each do |descr|
	    $report[descr.load_balancer_name] = Hash.new
	    $report[descr.load_balancer_name][:type] = descr.type
	    $report[descr.load_balancer_name][:scheme] = descr.scheme
	    $report[descr.load_balancer_name][:created_time] = descr.created_time
	    $report[descr.load_balancer_name][:dns_name] = descr.dns_name
	    $report[descr.load_balancer_name][:availability_zones] = Hash.new
	    $report[descr.load_balancer_name][:availability_zones][:name] = descr.availability_zones.map{ |i| i['zone_name'] }
	    $report[descr.load_balancer_name][:availability_zones][:subnet_id] = descr.availability_zones.map{ |i| i['subnet_id'] }
	    $report[descr.load_balancer_name][:security_group] = descr.security_groups

	    listeners = albclient.describe_listeners(
	      {
	        load_balancer_arn: descr.load_balancer_arn
	      }
	    )

	    target_group = albclient.describe_target_groups(
	      {
	        load_balancer_arn: descr.load_balancer_arn
	      }
	    )

	    attrs = albclient.describe_load_balancer_attributes(
	      {
	        load_balancer_arn: descr.load_balancer_arn
	      }
	    )

	    attrs.attributes.each do |attr|
	      $report[descr.load_balancer_name][:logging] = Hash.new
	      logged = attr.value if attr.key == 'access_logs.s3.enabled'
	      if logged == 'true'
	        $report[descr.load_balancer_name][:logging][:access_log] = 'enabled'
	      else
	        $report[descr.load_balancer_name][:logging][:access_log] = 'disabled'
	      end
	      s3_log = attr.value if attr.key == 'access_logs.s3.bucket'
	      if !s3_log == ''
	        $report[descr.load_balancer_name][:logging][:s3_log_location] = attr.value if attr.key == 'access_logs.s3.bucket'
	      else
	        $report[descr.load_balancer_name][:logging][:s3_log_location] = 'disabled'
	      end
	      s3_prefix = attr.value if attr.key == 'access_logs.s3.prefix'
	      if !s3_prefix.nil?
	        $report[descr.load_balancer_name][:logging][:s3_log_prefix] = attr.value if attr.key == 'access_logs.s3.prefix'
	      else
	        $report[descr.load_balancer_name][:logging][:s3_log_prefix] = 'disabled'
	      end
	    end
	  end

	  elasticlbs.load_balancer_descriptions.each do |descr|
	    attrs = elbclient.describe_load_balancer_attributes(
	      {
	        load_balancer_name: descr.load_balancer_name
	      }
	    )

	    $report[descr.load_balancer_name] = Hash.new
	    $report[descr.load_balancer_name][:type] = 'elastic'
	    $report[descr.load_balancer_name][:scheme] = descr.scheme
	    $report[descr.load_balancer_name][:created_time] = descr.created_time
	    $report[descr.load_balancer_name][:dns_name] = descr.dns_name
	    $report[descr.load_balancer_name][:availability_zones] = Hash.new
	    $report[descr.load_balancer_name][:availability_zones][:name] = descr.availability_zones
	    $report[descr.load_balancer_name][:availability_zones][:subnet_id] = descr.subnets
	    $report[descr.load_balancer_name][:security_group] = descr.security_groups
	    $report[descr.load_balancer_name][:logging] = Hash.new
	    if attrs.load_balancer_attributes.access_log.enabled == false
	      $report[descr.load_balancer_name][:logging][:access_log] = 'disabled'
	    else
	      $report[descr.load_balancer_name][:logging][:access_log] = 'enabled'
	    end
	    if attrs.load_balancer_attributes.access_log.s3_bucket_name.nil?
	      $report[descr.load_balancer_name][:logging][:s3_log_location] = 'disabled'
	    else
	      $report[descr.load_balancer_name][:logging][:s3_log_location] = attrs.load_balancer_attributes.access_log.s3_bucket_name
	    end
	    if attrs.load_balancer_attributes.access_log.s3_bucket_prefix.nil?
	      $report[descr.load_balancer_name][:logging][:s3_log_prefix] = 'disabled'
	    else
	      $report[descr.load_balancer_name][:logging][:s3_log_prefix] = attrs.load_balancer_attributes.access_log.s3_bucket_prefix
            end
	  end
        end
      end
    end

  end
end
