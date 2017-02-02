module Outputs

  def give_yaml(report)

    case report
    when 'DynamodbTables'
      require_relative '../reports/dynamodb'

      get_tables()
      puts $report.to_yaml
    end
  end

end
