class Klass
  def initialize(klass)
    @klass = klass
  end
  
  def all_methods
    @klass.instance_methods + @klass.private_instance_methods
  end
end
