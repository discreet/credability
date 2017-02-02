module Reports

  def get_tables()
    list = $client.list_tables()

    if list.table_names.empty?
      puts 'No Tables Available'
      $noreport = 'No Tables Available'
    else
      $report = Hash.new

      list.table_names.each do |table|
        data = $client.describe_table(
          {
	    table_name: table
	  }
        )

        $report[table] = Hash.new
        $report[table][:status] = data.table.table_status
        $report[table][:arn] = data.table.table_arn
        $report[table][:items] = data.table.item_count
        $report[table][:creation_date] = data.table.creation_date_time
      end
    end
  end

end

