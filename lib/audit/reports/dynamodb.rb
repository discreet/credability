module Audit
  class DynamoDB

    if $options.report == 'DynamodbTables'
      table_list = $client.list_tables()

      if table_list.table_names.empty?
        puts 'No Tables Available'
        $noreport = 'No Tables Available'
      else
	$report = Hash.new

	table_list.table_names.each do |table|
	  table_data = $client.describe_table(
	    {
	      table_name: table
	    }
	  )

	  $report[table] = Hash.new
	  $report[table][:status] = table_data.table.table_status
	  $report[table][:arn] = table_data.table.table_arn
	  $report[table][:items] = table_data.table.item_count
	  $report[table][:create_date] = table_data.table.creation_date_time
	end
      end
    end

  end
end
