module Audit
  class ReservedInstances

    def get_reservedinstances(report, client)
      report = $options.report
      client = $client

      if report == 'ReservedInstances'
        reserved = client.describe_reserved_instances({})

        if reserved.reserved_instances.empty?
          puts 'No Reserved Instanced Available'
	  $noreport = 'No Reserved Instances Available'
        else
          $report = Hash.new
          $report[:instances] = Hash.new

	  reserved.reserved_instances.each do |instance|
	    id = instance.reserved_instances_id
	    $report[:instances][id] = Hash.new
	    $report[:instances][id][:type] = instance.instance_type
	    $report[:instances][id][:count] = instance.instance_count
	    $report[:instances][id][:state] = instance.state
	    $report[:instances][id][:availability_zone] = instance.availability_zone
	    $report[:instances][id][:scope] = instance.scope
	    $report[:instances][id][:tenancy] = instance.instance_tenancy
	    $report[:instances][id][:offering_type] = instance.offering_type
	    $report[:instances][id][:offering_class] = instance.offering_class
	    $report[:instances][id][:product_os] = instance.product_description
	    $report[:instances][id][:start] = instance.start
	    $report[:instances][id][:end] = instance.end
	    $report[:instances][id][:duration] = instance.duration
	    $report[:instances][id][:currency] = instance.currency_code
	    $report[:instances][id][:usage_price] = instance.usage_price
	    $report[:instances][id][:fixed_price] = instance.fixed_price
	    $report[:instances][id][:recurring_charges] = Hash.new
	    instance.recurring_charges.each do |charge|
	      $report[:instances][id][:recurring_charges][:frequency] = charge.frequency
	      $report[:instances][id][:recurring_charges][:amount] = charge.amount
	    end
	    $report[:instances][id][:tags] = instance.tags
	  end
        end
      end
    end

  end
end

