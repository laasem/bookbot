#!/usr/bin/env ruby
$VERBOSE = true

require 'optparse'
options = Hash.new

# Need to make the options required.
option_parser = OptionParser.new { |opts|
  opts.on('-F <FILE>', '--file', 'Data file') { |file|
    options[:file] = file
  }
  opts.on('-f <FROM>', '--from', 'Change from') { |from|
    options[:from] = from
  }
  opts.on('-t <TO>', '--to', 'Change to') { |to|
    options[:to] = to
  }
}
option_parser.parse!

should_exit = false
unless options[:file]
  puts "Need file" 
  should_exit = true
end
unless options[:from]
  puts "Need from" 
  should_exit = true
end
unless options[:to]
  puts "Need to" 
  should_exit = true
end
exit if should_exit

File.readlines(options[:file]).each { |line|
  # The gsubs cascade, so that the " From said" things get done first.
  # Then the possessives. 
  from_speak_string       = "\" #{options[:from]} "
  to_speak_string         = "\" #{options[:to]} "
  to_possessive           = options[:to].strip == "I" ? "my" : options[:to]
  to_self                 = options[:to].strip == "I" ? "me" : options[:to]
  new_line                = line.gsub(from_speak_string, to_speak_string)
  # Need to figure out what a new line looks like, \n didn't match.
  new_line.gsub!("#{options[:from]}'s", to_possessive)
  from_start_line_string  = "#{options[:from]} "
  to_start_line_string    = "#{options[:to]} "
  new_line.gsub!(from_start_line_string, to_start_line_string)
  #new_line.gsub!("#{options[:from]}", to_self)
  puts new_line
}

