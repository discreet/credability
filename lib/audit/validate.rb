module Audit
  class Validate

    if $options.region.nil? and !$options.report.eql?('list')
      fail('-r or --region is a required option')
    end

    if $options.table.nil? and !$options.report.eql?('list')
      fail('-t or --table is required')
    end

    if !$options.credstash.nil? and $options.table.nil?
      fail('-c or --credstash is not valid without -t or --table')
    end

    if $options.credstash == 'get' and $options.credkey.nil?
      fail('--cred_key is required to fetch a credential')
    end

    if !$reports_available.include?($options.report) and !$options.report.eql?('list')
      fail('report specified is not valid')
    end

    if $options.output.nil? and !$options.path.nil? and $options.report.nil?
      fail('--report and --output must be defined')
    end

    if $options.output != 'html' and !$options.path.nil?
      fail('only html file outputs are currently supported')
    end

  end
end
