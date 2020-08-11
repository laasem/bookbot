# presenter/section/text_adapter.rb
#

module BookBot
  module Presenter

      class Text 
        def present(section)
          print ("Chapter %03d\n" % section.chapter_number )
          print ("[1429.271.0600] Firster Academy")
        end
      end 
        
  end
end

