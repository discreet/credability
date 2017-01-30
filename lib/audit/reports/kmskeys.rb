module Audit
  class KmsKeys

    def get_kms(report, client)
      report = $options.report
      client = $client

      if report == 'KmsKeys'
        key_list = client.list_aliases()

        if key_list.aliases.empty?
          puts 'No Keys Available'
          $noreport = 'No Keys Available'
        else
          $report = Hash.new

	  key_aliases = key_list.aliases.map{ |i| i['alias_name'] }

          key_aliases.each do |key_alias|
            key_data = client.describe_key(
	      {
	        key_id: key_alias
	      }
	    )
	    key_name  = key_alias.gsub(/^alias\//, '')

	    $report[key_name] = Hash.new
	    $report[key_name][:arn] = key_data.key_metadata.arn
	    $report[key_name][:state] = key_data.key_metadata.key_state
          end
        end
      end
    end

  end
end
