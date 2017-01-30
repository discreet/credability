module Audit
  class Filter

    def filter_results(credstash, filter, cred_data)
      credstash = $options.credstash
      filter = $options.filter
      cred_data = $cred_data

      if credstash == 'list' and !filter.nil?
        $filtered_data = cred_data.select { |i| i =~ /#{filter}/ }
      end
    end

  end
end
