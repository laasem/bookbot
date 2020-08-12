# presenter/section/text_adapter.rb
#

module BookBot
  module Presenter

      class Text 
        def present(section)
          print ("Chapter %03d\n" % section.chapter_number ) if section.chapter_number
          print ("\n#{section.header}\n\n") if section.header
          print section.to_s
        end
      end 
        
  end
end

