#!/usr/bin/env ruby
$VERBOSE = true

# section_report.rb
# This is just a test idea.
#
$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'yaml'
require 'ftl_book'

# Set defaults
section_dir = 'my_sections'
reports_dir   = 'my_reports'
sections = Hash.new

config_file = 'book_config.yml'
if File.exist?(config_file)  
  config = YAML.load_file(config_file)
  section_dir = config["section_dir"] if config["section_dir"]
  reports_dir = config["reports_dir"] if config["reports_dir"]
end

exit unless Dir.exist?(section_dir)

Dir.mkdir(reports_dir, 0755) unless Dir.exist?(reports_dir)

search_sections = File.join(section_dir, '*.txt')
filenames = Dir[search_sections]
sections  = Hash.new
filenames.each { |file|
  section = FTLBook::Section.new(file)
  section_name = section.file_name_label
  sections[section_name.to_sym] = section
}

section_list = sections.keys.sort
section_grades = Hash.new

# Write the per section report.
per_section_report_file = File.join(reports_dir, "report_per_section.txt")
File.open(per_section_report_file, 'w') { |file|
  section_list.each { |section|
    grade = sections[section].grade_level.to_s.to_sym
    section_grades[grade] = Array.new unless section_grades[grade]
    section_grades[grade] << sections[section].file_name
    file.print "%s \n" % sections[section].file_name
    file.puts "-----------------"
    file.print "\n\t Grade level: %.1f " % sections[section].grade_level
    file.print "\n\t Avg Word Length: %.1f " % sections[section].average_word_length
    file.print "\n\t Contractions: %d " % sections[section].contraction_count
    file.print "\n\t Total words: %d " % sections[section].count_words
    file.puts
    file.puts
  }
}

# Write the per grade report.
sorted_section_grades = section_grades.keys.sort
per_grade_report_file = File.join(reports_dir, "report_per_grade.txt")
File.open(per_grade_report_file, 'w') { |file|
  sorted_section_grades.each { |grade|
    file.puts "#{grade} : #{section_grades[grade]}"
  }
}

