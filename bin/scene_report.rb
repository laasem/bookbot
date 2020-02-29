#!/usr/bin/env ruby
$VERBOSE = true

# scene_report.rb
# This is just a test idea.
#
$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'yaml'
require 'ftl_book'

# Set defaults
scene_dir = 'my_scenes'
reports_dir   = 'my_reports'

config_file = 'book_config.yml'
if File.exist?(config_file)  
  config = YAML.load_file(config_file)
  scene_dir = config["scene_dir"] if config["scene_dir"]
  reports_dir = config["reports_dir"] if config["reports_dir"]
end

exit unless Dir.exist?(scene_dir)

Dir.mkdir(reports_dir, 0755) unless Dir.exist?(reports_dir)

search_scenes = File.join(scene_dir, '*.txt')
filenames = Dir[search_scenes]
scenes    = Hash.new
filenames.each { |file|
  scene = FTLBook::Scene.new(file)
  scene_name = scene.file_name_label
  scenes[scene_name.to_sym] = scene
}

scene_list = scenes.keys.sort
scene_grades = Hash.new

# Write the per scene report.
per_scene_report_file = File.join(reports_dir, "report_per_scene.txt")
File.open(per_scene_report_file, 'w') { |file|
  scene_list.each { |scene|
    grade = scenes[scene].grade_level.to_s.to_sym
    scene_grades[grade] = Array.new unless scene_grades[grade]
    scene_grades[grade] << scenes[scene].file_name
    file.print "%s \n" % scenes[scene].file_name
    file.puts "-----------------"
    file.print "\n\t Grade level: %.1f " % scenes[scene].grade_level
    file.print "\n\t Avg Word Length: %.1f " % scenes[scene].average_word_length
    file.print "\n\t Contractions: %d " % scenes[scene].contraction_count
    file.print "\n\t Total words: %d " % scenes[scene].count_words
    file.puts
    file.puts
  }
}

# Write the per grade report.
sorted_scene_grades = scene_grades.keys.sort
per_grade_report_file = File.join(reports_dir, "report_per_grade.txt")
File.open(per_grade_report_file, 'w') { |file|
  sorted_scene_grades.each { |grade|
    file.puts "#{grade} : #{scene_grades[grade]}"
  }
}

