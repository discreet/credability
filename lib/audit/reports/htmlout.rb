module Audit
  class HtmlOut

    html = File.read(File.expand_path("../../../../templates/report.html.erb", __FILE__))

    if !$options.path.nil?
      File.open("#{$options.path}/#{$options.report}.html", 'w') do |i|
        i.write ERB.new(html, nil, '-').result()
      end
    else
      puts ERB.new(html, nil, '-').result()
    end

  end
end
