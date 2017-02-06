module Reports

  def get_loadbalancers()
    elb_list = $elbclient.describe_load_balancers({})
    alb_list = $albclient.describe_load_balancers({})

    if alb_list.load_balancers.empty? and elb_list.load_balancer_descriptions.empty?
      puts 'No Load Balancers Available'
      $noreport = 'No Load Balancers Available'
      exit
    else
      $report = Hash.new

      alb_list.load_balancers.each do |descr|
        $report[descr.load_balancer_name] = Hash.new
	$report[descr.load_balancer_name][:type] = descr.type
	$report[descr.load_balancer_name][:scheme] = descr.scheme
	$report[descr.load_balancer_name][:creation_date] = descr.created_time
	$report[descr.load_balancer_name][:dns_name] = descr.dns_name

	$report[descr.load_balancer_name][:availability_zones] = Hash.new
	$report[descr.load_balancer_name][:availability_zones][:name] = descr.availability_zones.map { |i| i['zone_name'] }
	$report[descr.load_balancer_name][:availability_zones][:subnet_id] = descr.availability_zones.map { |i| i['subnet_id'] }
	$report[descr.load_balancer_name][:security_group] = descr.security_groups

	tags = $albclient.describe_load_balancer_tags(
	  {
	    load_balancer_arn: descr.load_balancer_arn
	  }
	)

	$report[descr.load_balancer_name][:tags] = Hash.new

	tags.tag_descriptions.each do |descr|
	  descr.tags.each do |tag|
	    $report[descr.load_balancer_name][:tags][tag.key] = tag.value
	  end
	end

	attrs = $albclient.describe_load_balancer_attributes(
	  {
	    load_balancer_arn: descr.load_balancer_arn
	  }
	)

	attrs.attributes.each do |attr|
	  $report[descr.load_balancer_name][:logging] = Hash.new
	  logged = attr.value if attr.key.eql?('access_logs.s3.enabled')
	  s3_log = attr.value if attr.key.eql?('access_logs.s3.bucket')
	  s3_prefix = attr.value if attr.key.eql?('access_logs.s3.prefix')

	  if logged.eql?('true')
	    $report[descr.load_balancer_name][:logging][:access_log] = 'enabled'
	  else
	    $report[descr.load_balancer_name][:logging][:access_log] = 'disabled'
	  end

	  if s3_log == ''
	    $report[descr.load_balancer_name][:logging][:s3_log_location] = attr.value if attr.key.eql?('access_logs.s3.bucket')
	  else
	    $report[descr.load_balancer_name][:logging][:s3_log_location] = 'disabled'
	  end

	  if s3_prefix.nil?
	    $report[descr.load_balancer_name][:logging][:s3_log_prefix] = attr.value if attr.key.eql?('access_logs.s3.prefix')
	  else
	    $report[descr.load_balancer_name][:logging][:s3_log_prefix] = 'disabled'
	  end
	end
      end

      elb_list.load_balancer_descriptions.each do |descr|
        attrs = $elbclient.describe_load_balancer_attributes(
	  {
	    load_balancer_name: descr.load_balancer_name
	  }
	)

	$report[descr.load_balancer_name] = Hash.new
	$report[descr.load_balancer_name][:type] = 'elastic'
	$report[descr.load_balancer_name][:scheme] = descr.scheme
	$report[descr.load_balancer_name][:creation_time] = descr.created_time
	$report[descr.load_balancer_name][:dns_name] = descr.dns_name

	$report[descr.load_balancer_name][:availability_zones] = Hash.new
	$report[descr.load_balancer_name][:availability_zones][:name] = descr.availability_zones
	$report[descr.load_balancer_name][:availability_zones][:subnet_id] = descr.subnets
	$report[descr.load_balancer_name][:security_group] = descr.security_groups

	tags = $elbclient.describe_tags(
	  {
	    load_balancer_names: [descr.load_balancer_name]
	  }
	)

	$report[descr.load_balancer_name][:tags] = Hash.new

	tags.tag_descriptions.each do |descr|
	  descr.tags.each do |tag|
	    $report[descr.load_balancer_name][:tags][tag.key] = tag.value
	  end
	end

	$report[descr.load_balancer_name][:logging] = Hash.new

	if attrs.load_balancer_attributes.access_log.enabled.eql?(false)
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

