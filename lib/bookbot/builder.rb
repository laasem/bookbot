# builder.rb
#
# Discussion
#   The utility script 'build_book' slurps the config file
#     - sets the data Hash variables
#     - ensures the directories are present
#     - calls Builder with the data
#
#   Which means that the Builder must slurp the file?
#     - Or something else?
#     - It must set chapter numbers for the proper sections.
#
module BookBot
  class Builder

    attr_reader :post_sections, :pre_sections, :section_list, :title, :title_string

    def initialize(data)
      @title          = data[:title]
      @title_string   = make_title_string
      @pre_sections   = data[:pre_sections]
      @post_sections  = data[:post_sections]
      @sections       = data[:sections]
      @section_list   = make_section_list
    end

    def make_title_string
      str = @title.clone
      str.downcase!
      str.gsub!(/ /, '_')
      str.gsub!(/[^a-zA-Z0-9_]/, "")
      str
    end

    def make_section_list
      section_list = Array.new
      section_list << @pre_sections
      section_list << @sections
      section_list << @post_sections
      section_list.flatten
    end

  end
end

