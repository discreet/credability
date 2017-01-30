module Audit
  class Validate

    def has_region?(region, report)
      region = $options.region
      report = $options.report

      if region.nil? and !report.eql?('list')
        fail('-r or --region is a required option')
      end
    end

    def has_table?(table, report)
      table = $options.table
      report = $options.report

      if table.nil? and !report.eql?('list')
        fail('-t or --table is required')
      end
    end

    def can_credstash?(credstash, table)
      credstash = $options.credstash
      table = $options.table

      if !credstash.nil? and table.nil?
        fail('-c or --credstash is not valid without -t or --table')
      end
    end

    def can_credkey?(credstash, credkey)
      credstash = $options.credstash
      credkey = $options.credkey

      if credstash == 'get' and credkey.nil?
        fail('--cred_key is required to fetch a credential')
      end
    end

    def has_report?(reports, report)
      reports = $reports_available
      report = $options.report

      if !reports.include?(report) and !report.eql?('list')
        fail('report specified is not valid')
      end
    end

    def can_output?(output, path, report)
      output = $options.output
      path = $options.path
      report = $options.report

      if output.nil? and !path.nil? and report.nil?
        fail('--report and --output must be defined')
      end
    end

    def can_html?(output, path)
      output = $options.output
      path = $options.path

      if output != 'html' and !path.nil?
        fail('only html file outputs are currently supported')
      end
    end

  end
end
