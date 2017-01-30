module Audit
  class HtmlOut

    def gen_html(path, report)
      path = $options.path
      report = $options.report

      html = File.read(File.expand_path("../../../../templates/report.html.erb", __FILE__))

      if !path.nil?
        File.open("#{path}/#{report}.html", 'w') do |i|
          i.write ERB.new(html, nil, '-').result()
        end
      else
        puts ERB.new(html, nil, '-').result()
      end
    end

  end
end
