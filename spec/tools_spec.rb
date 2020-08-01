# tools_spec.rb
#

require 'bookbot'
module BookBot

  RSpec.describe 'From the module' do

  it 'converts a UTF-8 string to ascii' do
    string = " \u201D h\u2026i \u201D "
    new_string = Tools.scrub(string, 'ascii')
    expect(new_string).to eq('" h...i "')
  end

  it 'removes apostrophe words' do
    string = "  We'll wentn't to's your've home're   "
    new_string = Tools.scrub(string, 'report')
    expect(new_string).to eq(["we", "went", "to", "your", "home"])
  end

  end
end

