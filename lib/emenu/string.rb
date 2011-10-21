class String

  def indent
    tokens = self.split ("\n")
    result = ''
    if tokens.size > 0
      prespace_index = tokens[0].index(/\S/)
      tokens.each do |token|
        result << token[prespace_index,(token.length - prespace_index)] << "\n"
      end
    end
    return result
  end

end
