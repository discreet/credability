module Audit
  class IamPolicies

    if $options.report == 'IamPolicies'
      policy_list = $client.list_policies(
        {
          scope: 'Local',
	  only_attached: false
	}
      )

      if policy_list.policies.empty?
        puts 'No Local Policies Available'
        $noreport = 'No Local Policies Available'
      else
        $report = Hash.new

	policy_arns = policy_list.policies.map{ |i| i['arn'] }

        policy_arns.each do |arn|
          policy_data = $client.get_policy(
            {
	      policy_arn: arn
	    }
	  )
	  policy_name   = policy_data.policy.policy_name

	  document_data = $client.get_policy_version(
	    {
	      policy_arn: policy_data.policy.arn,
	      version_id: policy_data.policy.default_version_id
	    }
	  )

	  $report[policy_name] = Hash.new
	  $report[policy_name][:arn] = policy_data.policy.arn
	  $report[policy_name][:default_version] = policy_data.policy.default_version_id
	  $report[policy_name][:version] = document_data.policy_version.version_id
	  $report[policy_name][:creation_date] = policy_data.policy.create_date
	  $report[policy_name][:update_date] = policy_data.policy.update_date
	  $report[policy_name][:attach_count] = policy_data.policy.attachment_count
          if $options.output == 'pretty' or $options.output == 'html' or $options.output.nil?
	    $report[policy_name][:policy_document] = URI.decode(document_data.policy_version.document)
          end
	end
      end
    end

  end
end
