module Audit
  class IamRoles

    def get_roles(report, client)
      report = $options.report
      client = $client

      if report == 'IamRoles'
        role_list = client.list_roles()

        if role_list.roles.empty?
          puts 'No Roles Available'
          $noreport = 'No Roles Available'
        else
          $report = Hash.new

	  roles = role_list.roles.map{ |i| i['role_name'] }

          roles.each do |role|
            policy_data = client.list_attached_role_policies(
              {
	        role_name: role
	      }
	    )

	    role_data = client.get_role(
              {
	        role_name: role
	      }
	    )

	    $report[role] = Hash.new
	    $report[role][:arn] = role_data.role.arn
	    $report[role][:creation_date] = role_data.role.create_date
	    $report[role][:policies] = Hash.new
	    $report[role][:policies][:policy_name] = policy_data.attached_policies.map{ |i| i['policy_name'] }
	    $report[role][:policies][:policy_arn] = policy_data.attached_policies.map{ |i| i['policy_arn'] }
	  end
        end
      end
    end

  end
end
