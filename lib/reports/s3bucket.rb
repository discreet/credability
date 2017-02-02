module Reports

  def get_s3buckets()
    list = $client.list_buckets()

    if list.buckets.empty?
      puts 'No S3 Buckets Available'
      $noreport = 'No S3 Buckets Available'
      exit
    else
      $report = Hash.new

      list.buckets.each do |bucket|
        logged = $client.get_bucket_logging(
	  {
	    bucket: bucket.name
	  }
	)

	$report[bucket.name] = Hash.new
	$report[bucket.name][:creation_date] = bucket.creation_date

	if logged.logging_enabled.nil?
	  $report[bucket.name][:logging] = false
	else
	  $report[bucket.name][:logging] = true
	end

	if !logged.logging_enabled.nil?
	  $report[bucket.name][:target] = logged.logging_enabled.target_bucket
	else
	  $report[bucket.name][:target] = 'none'
	end
      end
    end
  end

end

