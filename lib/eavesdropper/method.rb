module Eavesdropper
  class Method
    def initialize(method)
      @method = method
    end

    def alias_without_logging
      "#{method_without_terminator}_without_logging#{method_terminator}".to_sym
    end
  
    def alias_with_logging
      "#{method_without_terminator}_with_logging#{method_terminator}".to_sym
    end
  
    private
    def method_without_terminator
      @method.to_s.match(/([^?!]*)[?!]?/)[1]
    end
  
    def method_terminator
      @method.to_s.match(/[^?!]*([?!]?)/)[1]
    end
  end
end
