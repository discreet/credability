module Audit
  class Rcredstash

    def configure_credstash?(table, credstash, report)
      table = $options.table
      credstash = $options.credstash
      report = $options.report

      if !table.nil? and !credstash.nil? or !report.nil? or !report == 'list'
        CredStash.configure do |config|
          config.table_name = $options.table
        end
      end
    end

    def credstash_action(credstash, context, table, credkey)
      credstash = $options.credstash
      context = $options.context
      table = $options.table
      credkey = $options.credkey

      case credstash
      when 'list'
        $cred_data = CredStash.list.keys
      when 'get'
        if context.nil?
          $cred_data = CredStash.get(credkey)
        else
          $cred_data = system("credstash -t #{table} get #{credkey} #{context.gsub(/,/, ' ')}")
          exit
        end
      end
    end

  end
end
