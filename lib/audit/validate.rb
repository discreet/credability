module Audit
  class Validate

    if $options.region.nil? and $options.report != 'list'
      fail('-r or --region is a required option')
    end

    if !$options.credstash.nil? and $options.table.nil?
      fail('-c or --credstash is not valid without -t or --table')
    end

    if $options.credstash == 'get' and $options.credkey.nil?
      fail('--cred_key is required to fetch a credential')
    end

    if !$reports_available.include? $options.report and !$options.report.nil? and $options.report != 'list'
      fail("#{$options.report} is not a valid report")
    end

    if $options.output.nil? and !$options.path.nil? and $options.report.nil?
      fail('--report and --output must be defined')
    end

    if $options.output != 'html' and !$option.path.nil?
      fail('only html file outputs are currently supported')
    end

  end
end
