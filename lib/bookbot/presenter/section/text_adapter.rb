# presenter/section/text_adapter.rb
#

module BookBot
  module Presenter

      class Text 
        def present(section)
          print ("Chapter %03d\n" % section.chapter_number )
          print section.to_s
        end
      end 
        
  end
end

