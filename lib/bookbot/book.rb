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
      book            =  make_filename("txt")
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
          file.puts sec.to_s
        }
      }
    end

  end
end

