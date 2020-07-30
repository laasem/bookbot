# book.rb
#
module BookBot
  class Book

    attr_reader :sections, :title

    def initialize(data)
      @data     = data
      @title    = data.fetch( :title, "To kill a plan" )
      @pre      = data.fetch( :pre, Array.new )
      @chapters = data.fetch( :chapters, Array.new )
      @post     = data.fetch( :post, Array.new )
      generate_section_list
      write_book
    end

    def generate_section_list
      @sections = Array.new
      [ @pre, @chapters, @post ].each { |group|
        @sections << group
      }
      @sections.flatten!
    end

    def write_book
      output_dir  = "output"
      Dir.mkdir(output_dir) unless File.directory?(output_dir)
      text_file =  "#{output_dir}/book.txt"
      File.open(text_file, "a+") { |file|
        @sections.each { |sec|
          file.puts(sec)
        }
      }
    end

  end
end

