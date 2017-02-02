module Outputs

  def show_reports(report)

    if report.eql?('list')
      puts $reports_available
    end
  end

end

