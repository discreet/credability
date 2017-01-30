module Audit
  class S3Buckets

    if $options.report == 'S3Buckets'
      bucket_list = $client.list_buckets()

      if bucket_list.buckets.empty?
        puts 'No Buckets Available'
        $noreport = 'No Buckets Available'
      else
        $report = Hash.new

	bucket_list.buckets.each do |bucket|
          bucket_logged = $client.get_bucket_logging(
	    {
	      bucket: bucket.name
	    }
	  )

	  $report[bucket.name] = Hash.new
	  $report[bucket.name][:creation_date] = bucket.creation_date
	  if bucket_logged.logging_enabled.nil?
	    $report[bucket.name][:logging] = false
	  else
	    $report[bucket.name][:logging] = true
	  end
          if !bucket_logged.logging_enabled.nil?
	    $report[bucket.name][:target] = bucket_logged.logging_enabled.target_bucket
	  else
	    $report[bucket.name][:target] = 'none'
          end
        end
      end
    end

  end
end
