module Outputs

  def give_json(report)

    case report
    when 'DynamodbTables'
      require_relative '../reports/dynamodb'

      get_tables()
      puts JSON.generate($report)
    end
  end

end

