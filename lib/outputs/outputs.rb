module Outputs

  def give_report(report, output)

    require_relative 'reports'
    show_reports(report)

    case output
    when 'json'
      require_relative 'json'
      give_json(report)
    when 'yaml'
      require_relative 'yaml'
      give_yaml(report)
    when 'pretty', nil
      require_relative 'console'
      give_console(report)
    end
  end

end

