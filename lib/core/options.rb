class Options

  def self.parse(args)
    options = OpenStruct.new
    parser = OptionParser.new do |opts|
      opts.banner = 'Usage: audit-aws [options]'

      opts.on('-r', '--region REGION', 'aws region to query') do |region|
        options.region = region
      end

      opts.on('-t', '--table TABLE', 'dynamodb table to query') do |table|
        options.table = table
      end

      opts.on('-c', '--credstash ACTION', 'credstash action; get, list') do |credstash|
        options.credstash = credstash
      end

      opts.on('--cred_key KEY', 'credstash key for the credential to fetch') do |credkey|
        options.credkey = credkey
      end

      opts.on('--context CONTEXT', 'comma separated key value pair encryption context') do |context|
        options.context = context
      end

      opts.on('--filter FILTER', 'regex filter for response data') do |filter|
        options.filter = filter
      end

      opts.on('--report REPORT', 'the name of the report to run') do |report|
        options.report = report
      end

      opts.on('--output OUTPUT', 'output format; json, yaml, pretty') do |output|
        options.output = output
      end

      opts.on_tail('-h', '--help', 'print help menu') do | help|
        puts opts
        exit
      end
    end
    parser.parse!(args)
    options
  end

end
$options = Options.parse(ARGV)

