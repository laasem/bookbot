# tools.rb
#
module BookBot
  module Tools

    # Takes a string. If style is 'ascii' (default), returns an ASCII'd 
    # version of the string, with leading and trailing whitespace removed.
    # If style is 'report', returns an array with words in lower case.
    # Contractions and non-alpha characters have been removed.
    def scrub(string , style = 'ascii' )
      string.gsub!(/\uFEFF/, '')    # BOM
      string.gsub!(/\u2018/, "\'")  # Apos
      string.gsub!(/\u2019/, "\'")  # Apos
      string.gsub!(/\u0060/, "\'")  # Apos
      string.gsub!(/\u00B4/, "\'")  # Apos
      string.gsub!(/\u201C/, "\"")  # Double Quote
      string.gsub!(/\u201D/, "\"")  # Double Quote
      string.gsub!(/\u2026/, "...") # Ellipsis
      string.strip!

      if ( style == 'report' )
        string.downcase!
        string.gsub!(/n't/, ' ')
        string.gsub!(/'ll/, ' ')
        string.gsub!(/'s/, ' ')
        string.gsub!(/'ve/, ' ')
        string.gsub!(/'re/, ' ')
        clean_string = string.gsub(/[,:!.?'"-]/, ' ')
        clean_array  = clean_string.split()
        clean_array.each { |word|
          clean_array.delete(word) unless word =~ /[aeiou]/i
          clean_array.delete(word) if word =~ /^ing/i
        }
        return clean_array
      end
    
      string
    end
    module_function :scrub

  end 
end
