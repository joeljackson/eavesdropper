# This class will proxy all calls to it's object and record what the call did
module Eavesdropper
  class Listener
    def initialize(object)
      @object = object
    end
    
    def call( method_name, *arguments, &block)
      response = @object.send method_name, *arguments, &block
      Eavesdropper.logger.add( Eavesdropper.log_level ) {
        "#{@object.class.to_s} called '#{method_name}' with '#{arguments}' and returned '#{response}'"
      }
      response
    rescue StandardError => error
      Eavesdropper.logger.add( Eavesdropper.log_level ) {
        "#{@object.class.to_s} called '#{method_name}' with '#{arguments}' and raised #{error}"
      }
      raise error
    end
  end
end
