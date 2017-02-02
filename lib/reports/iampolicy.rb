module Reports

  def get_policies()

    list = $client.list_policies(
      {
        scope: 'Local',
	only_attached: false
      }
    )

    if list.policies.empty?
      puts 'No Local IAM Policies Available'
      $noreport = 'No Local IAM Policies Available'
      exit
    else
      $report = Hash.new

      list.policies.map { |i| i['arn'] }.each do |arn|
        data = $client.get_policy(
	  {
	    policy_arn: arn
	  }
	)
	name = data.policy.policy_name

	doc = $client.get_policy_version(
	  {
	    policy_arn: data.policy.arn,
	    version_id: data.policy.default_version_id
	  }
	)

	$report[name] = Hash.new
	$report[name][:arn] = data.policy.arn
	$report[name][:default_version] = data.policy.default_version_id
	$report[name][:version] = doc.policy_version.version_id
	$report[name][:creation_date] = data.policy.create_date
	$report[name][:updated_date] = data.policy.update_date
	$report[name][:attached_count] = data.policy.attachment_count

	if $options.output.eql?('pretty') or $options.output.eql?('html') or $options.output.nil?
	  $report[name][:policy_document] = URI.decode(doc.policy_version.document)
	end
      end
    end
  end

end

