module Reports

  def get_keys()

    list = $client.list_aliases()

    if list.aliases.empty?
      puts 'No Keys Available'
      $noreport = 'No Keys Available'
      exit
    else
      $report = Hash.new

      key_aliases = list.aliases.map { |i| i['alias_name'] }.each do |key_alias|
        data = $client.describe_key(
	  {
	    key_id: key_alias
	  }
	)
	name = key_alias.gsub(/^alias\//, '')

	$report[name] = Hash.new
	$report[name][:arn] = data.key_metadata.arn
	$report[name][:state] = data.key_metadata.key_state
      end
    end
  end

end

