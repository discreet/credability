module Audit
  class Filter

    if $options.credstash == 'list' and !$options.filter.nil?
      $filtered_data = $cred_data.select { |i| i =~ /#{$options.filter}/ }
    end

  end
end
