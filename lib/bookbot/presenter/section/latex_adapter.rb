# section/latex_adapter.rb
#

module BookBot
  module Presenter
    
    class Latex
    
      def present(section)
        text = ''
        text += ("\\textbf{Chapter %03d}" % section.chapter_number) if section.chapter_number
        text += "\n"
        text += ("\\textbf{#{section.header}}") if section.header
        text += "\n"
        text += section.to_s
        text
      end

    end
  end
end
