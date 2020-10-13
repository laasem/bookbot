#!/usr/bin/env ruby
$VERBOSE = true

require 'optparse'

opts                = Hash.new
opts[:max]          = 3600
opts[:input_dir]    = '.'
opts[:output_dir]   = 'grouped_sections'
opts[:report]       = false
opts[:write]        = false

option_parser       = OptionParser.new { |opt|
  opt.on( '-i <DIR>', '--input', 'Input Directory') { |i|
    opts[:input_dir]  = i
  }
  opt.on( '-o <DIR>', '--output', 'Output Directory') { |o|
    opts[:output_dir] = o
  }
  opt.on( '-m <NUM>', '--max', 'Maximum words per group') { |m|
    opts[:max]        = m.to_i
  }
  opt.on( '-r', '--report', 'Overall report' ) { |r|
    opts[:report]     = true
  }
  opt.on( '-w', '--write', 'Write groups' ) { |w|
    opts[:write]      = true
  }
}
option_parser.parse!

max           = opts[:max]
input_dir     = opts[:input_dir]
output_dir    = opts[:output_dir]
show_report   = opts[:report]
write_groups  = opts[:write]

unless File.directory?(input_dir)
  puts "#{input_dir} is not a directory" 
  exit
end
unless File.directory?(output_dir)
  puts "#{output_dir} is not a directory"
  exit
end

words               = 0
section_list        = Array.new
grouped_sections    = Array.new
section_hash        = Hash.new

sections    = Dir.glob("#{input_dir}/*.txt")

sections.each { |section|
  next unless File.file?(section)
  # Need to resolve this; keep a "skips" and remove the hardcoding.
  next if section.match("1429_270_1500_firster_academy.txt")
  section_word_count = File.read(section).split(/ /).count
  section_hash[section.to_sym] = section_word_count
  temp_count = words + section_word_count
  if temp_count < max
    section_list << section
    words += section_word_count
  else
    grouped_sections << section_list.clone
    section_list.clear    
    words = 0
    section_list << section
    words += section_word_count
  end
}
grouped_sections << section_list.clone if section_list.count > 0

if show_report
  puts "Looking at grouped sections."
  grand_total = 0
  group_number = 0
  grouped_sections.each { |group|
    group_number += 1
    total_word_count = 0
    puts "Group number #{group_number} has #{group.count}"
    group.each { |section|
      word_count = section_hash[section.to_sym]
      total_word_count += word_count
      printf("\t %d \t %s \n" % [ word_count, section ] )
    }
    grand_total += total_word_count
    printf("\t %d \t total words\n" % total_word_count )
  }
    
  puts "Grand total: #{grand_total}" 
end

if write_groups
  group_number = 1
  grouped_sections.each { |group|
    group_file_name = "#{output_dir}/group_#{group_number}.txt"
    File.open(group_file_name, 'w') { |group_file|
      group.each { |section|
        data = File.read(section)
        group_file.puts(data)
        group_file.puts("\n\n\n\n\n")
      }
    group_number += 1
    }
  }
end

