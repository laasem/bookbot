# spec/presenter/text_section_spec.rb
#

require 'bookbot'
module BookBot

  RSpec.describe 'A LaTeX presenter' do

    let (:section)              { BookBot::Section.new('spec/data/test_section.txt', true) }
    let (:set_chapter_number )  { section.chapter_number = 1 }
    #let (:latex_presenter )     { set_chapter_number; BookBot::Presenter.adapter_for(:section, :latex) }
    let (:latex_presenter )     { BookBot::Presenter.adapter_for(:section, :latex) }

    it 'has a chapter number' do
      set_chapter_number
      expect(latex_presenter.present(section)).to match(/\\textbf{Chapter 001}/) 
    end

    it 'has a header' do
      expect(latex_presenter.present(section)).to match(/\\textbf{\[1429.171.2047\] .*Hall}/)
    end

    it 'has text' do
      expect(latex_presenter.present(section)).to match(/You're weird/)
    end


  end
end
