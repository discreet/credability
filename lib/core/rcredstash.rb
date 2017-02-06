module Core
  def credstash_configure(table)

    CredStash.configure do |config|
      config.table_name = table
    end
  end

  def credstash_action(table, credstash, credkey, context, filter)

    case credstash
    when 'list'
      if filter.nil?
        puts CredStash.list.keys
      else
        puts CredStash.list.keys.select { |i| i=~ /#{filter}/ }
      end
    when 'get'
      if context.nil?
        puts CredStash.get(credkey)
      else
	context_hash = Hash.new

	context = context.split(',').each do |i|
	  context = i.split('=')
	  context_hash[context[0]] = context[1]
	end

	puts CredStash.get(credkey, context: context_hash )
	exit
      end
    end
  end

end

