module Audit
  class Rcredstash

    if !$options.table.nil? and !$options.credstash.nil? or !$options.report.nil? or !$options.report == 'list'
      CredStash.configure do |config|
        config.table_name = $options.table
      end
    end

    case $options.credstash
    when 'list'
      $cred_data = CredStash.list.keys
    when 'get'
      if $options.context.nil?
        $cred_data = CredStash.get($options.credkey)
      else
	context = $options.context.gsub(/,/, ' ')
        $cred_data = system("credstash -t #{$options.table} get #{$options.credkey} #{context}")
        exit
      end
    end

  end
end
