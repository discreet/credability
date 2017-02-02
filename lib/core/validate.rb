module Core

  def needs_region?(region, report)

    if region.nil? and !report.eql?('list')
      fail('-r or --region is a required option')
    end
  end

  def needs_table?(table, report)

    if table.nil? and !report.eql?('list')
      fail('-t or --table is required')
    end
  end

  def can_credstash?(credstash, table)

    if !credstash.nil? and table.nil?
      fail('-c or --credstash is not valid without -t or --table')
    end
  end

  def can_fetch?(credstash, credkey)

    if credstash.eql?('get') and credkey.nil?
      fail('--cred_key is required to fetch a credential')
    end
  end

  def report_valid?(reports, report)

    if !report.nil?
      if !reports.include?(report) and !report.eql?('list')
        fail('report specified is not valid')
      end
    end
  end

  def report_path?(output, path, report)

    if output.nil? and !path.nil? and report.nil?
      fail('--report and --output must be defined')
    end
  end

  def output_report?(output, path)

    if !output.eql?('html') and !path.nil?
      fail('only html file outputs are currently supported')
    end
  end

end

