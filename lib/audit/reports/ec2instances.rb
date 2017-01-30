module Audit
  class Ec2Instances

    def get_ec2instance(report, client)
      report = $options.report
      client = $client

      if report == 'Ec2Instances'
        instances = client.describe_instances({})

        if instances.reservations.empty?
          puts 'No EC2 Instances Available'
	  $noreport = 'No EC2 Instances Available'
        else
          $report = Hash.new
	  $report[:instances] = Hash.new

	  instances.reservations.each do |reservation|
	    reservation.instances.each do |instance|
	      id = instance.instance_id
	      $report[:instances][id] = Hash.new
              $report[:instances][id][:state] = instance.state.name
	      $report[:instances][id][:private_dns] = instance.private_dns_name
	      if instance.public_dns_name.empty?
	        $report[:instances][id][:public_dns] = nil
	      end
	      $report[:instances][id][:key_name] = instance.key_name
	      $report[:instances][id][:type] = instance.instance_type
	      $report[:instances][id][:launch_time] = instance.launch_time
	      $report[:instances][id][:availability_zone] = instance.placement.availability_zone
	      $report[:instances][id][:tenancy] = instance.placement.tenancy
	      $report[:instances][id][:monitoring] = instance.monitoring.state
	      $report[:instances][id][:subnet] = instance.subnet_id
	      $report[:instances][id][:vpc] = instance.vpc_id
	      $report[:instances][id][:private_ip] = instance.private_ip_address
	      $report[:instances][id][:public_ip] = instance.public_ip_address
	      $report[:instances][id][:architecture] = instance.architecture
	      $report[:instances][id][:virtualization] = instance.virtualization_type
	      $report[:instances][id][:tags] = Hash.new
	      instance.tags.each do |tag|
	        $report[:instances][id][:tags][tag.key] = tag.value
	      end
	      $report[:instances][id][:security_group] = Hash.new
	      instance.security_groups.each do |group|
	        $report[:instances][id][:security_group][:name] = group.group_name
	        $report[:instances][id][:security_group][:id] = group.group_id
	      end
	      if !instance.iam_instance_profile.nil?
	        $report[:instances][id][:iam] = Hash.new
	        $report[:instances][id][:iam][:profile_arn] = instance.iam_instance_profile.arn
	        $report[:instances][id][:iam][:profile_id] = instance.iam_instance_profile.id
	      end
	    end
          end
        end
      end
    end

  end
end
