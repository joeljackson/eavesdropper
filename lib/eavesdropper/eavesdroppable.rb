module Eavesdropper
  module Eavesdroppable
    def self.included(klass)
      klass.instance_variable_set :'@eavesdrop_logged_methods', []
      klass.extend ClassMethods
      
      def klass.method_added(method_name)
        if @eavesdrop_logged_methods.include?(method_name)
          @eavesdrop_logged_methods.delete method_name
          create_logged_method self, method_name
          self.send :alias_method, method_name, Eavesdropper::Method.new(method_name).alias_with_logging
        end
      end
    end
    
    module ClassMethods
      def eavesdrop_on(*methods)
        methods.each do |method_name|
          if Klass.new(self).all_methods.include?(method_name)
            create_logged_method self, method_name
            self.send :alias_method, method_name, Eavesdropper::Method.new(method_name).alias_with_logging
          else
            @eavesdrop_logged_methods.push method_name
          end
        end
      end

      
      
      def create_logged_method(klass, method_name)
        method = Eavesdropper::Method.new(method_name)

        klass.send :alias_method, method.alias_without_logging, method_name
        
        klass.send :define_method, method.alias_with_logging do |*args|
          Eavesdropper::Listener.new(self).call(method.alias_without_logging, *args)
        end

        klass.send :private, method.alias_with_logging unless klass.instance_methods.include?(method_name)
      end
    end
  end
end
