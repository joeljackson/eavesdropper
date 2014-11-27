# This class will proxy all calls to it's object and record what the call did
class Eavesdropper::Eavesdropper
  def initialize(object)
    @object = object
  end

  def call( method_name, *arguments)
    response = @object.send method_name, *arguments
    Eavesdropper.logger.add( Eavesdropper.log_level ) {
      "#{@object.class.to_s} called #{method_name} and returned #{response}"
    }
    response
  end
end
