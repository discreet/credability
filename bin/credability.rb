require_relative '../lib/requirements'

# Validation functions
#
needs_region?($options.region, $options.report)
needs_table?($options.table, $options.report)
can_credstash?($options.credstash, $options.table)
can_fetch?($options.credstash, $options.credkey)
report_valid?($reports_available, $options.report)
report_path?($options.output, $options.path, $options.report)
output_report?($options.output, $options.path)

# CredStash functions
#
credstash_configure($options.table)
credstash_action($options.table, $options.credstash, $options.credkey, $options.context, $options.filter)

# Output functions
#
show_reports($options.report)

