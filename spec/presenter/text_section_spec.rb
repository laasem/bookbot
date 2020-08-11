# spec/presenter/text_section_spec.rb
#

require 'bookbot'
module BookBot

  RSpec.describe 'A text presenter' do

    let (:section)              { BookBot::Section.new('spec/data/test_section.txt') }
    let (:set_chapter_number )  { section.chapter_number = 1 }
    let (:text_presenter )      { set_chapter_number; BookBot::Presenter.adapter_for(:section, :text) }

    it 'has a chapter header and number' do
      expect { text_presenter.present(section)}.to output(/Chapter 001/).to_stdout 
    end

    it 'has an identifier' do
      expect { text_presenter.present(section)}.to output(/\[1429/).to_stdout 
    end

    it 'has text' do
      expect { text_presenter.present(section)}.to output(/You're weird/).to_stdout 
    end


  end
end
