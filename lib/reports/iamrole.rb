module Reports

  def get_roles()

    list = $client.list_roles()

    if list.roles.empty?
      puts 'No IAM Roles Available'
      $noreport = 'No IAM Roles Available'
      exit
    else
      $report = Hash.new

      list.roles.map { |i| i['role_name'] }.each do |role|
        policy_data = $client.list_attached_role_policies(
	  {
	    role_name: role
	  }
	)

        role_data = $client.get_role(
	  {
	    role_name: role
	  }
	)

	$report[role] = Hash.new
	$report[role][:arn] = role_data.role.arn
	$report[role][:creation_date] = role_data.role.create_date
	$report[role][:policies] = Hash.new
	$report[role][:policies][:name] = policy_data.attached_policies.map { |i| i['policy_name'] }
	$report[role][:policies][:arn] = policy_data.attached_policies.map { |i| i['policy_arn'] }
      end
    end
  end

end


