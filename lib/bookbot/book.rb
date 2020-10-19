# book.rb
#
module BookBot
  class Book

    PAGE_BREAK      = "\n__page_break__\n"

    attr_reader :title, :section_list

    def initialize(data)
      @data         = data
      @title        = data.fetch( :title, "To kill a plan" )
      @pre          = data.fetch( :pre, Array.new )
      @post         = data.fetch( :post, Array.new )
      @book_dir     = data.fetch( :book_dir )
      @report_dir   = data.fetch( :report_dir )
      @sections     = data.fetch( :sections )
      @section_list = generate_section_list
    end

    def generate_section_list
      @sections.keys.to_s
    end

    def make_filename(suffix)
      title = @title.clone
      title.gsub!(/ /, '_')
      title.gsub!(/[\W]/, '')
      "#{@book_dir}/#{title.downcase}.#{suffix}"
    end

    def write_text
      book    =  make_filename("txt")
      File.open(book, "w+") { |file|
        @sections.each_value { |sec|
          file.puts PAGE_BREAK
          file.print("Chapter %03d" % sec.chapter_number) if sec.chapter_number
          file.puts("\n\n")
          file.puts sec.to_s
          file.puts
        }
      }
    end

    def write_latex
      book    = make_filename("tex")
      File.open(book, "w+") { |file|
        @sections.each_value { |sec|
          header = true if sec.header
          presenter = BookBot::Presenter.adapter_for(:section, :latex)
          text = presenter.present(sec)
          file.puts text
        }
      }
    end

=begin
    def write_reports
      # Needs error checking for the reports directory. 
      Dir.mkdir(@report_dir) unless File.directory?(@report_dir)
      if File.directory?(@report_dir)
        per_section_report_file = File.join(@report_dir, "report_per_section.txt")
        per_section = File.open( per_section_report_file, 'w')
        per_grade_report_file   = File.join(@report_dir, "report_per_grade.txt")
        per_grade   = File.open( per_grade_report_file, 'w')
        @sections.each_value { |sec|
        }
      end
    end
=end
  end
end

