require './lib/eavesdropper'

describe Eavesdropper::Eavesdroppable do
  describe "self.included" do
    subject { klass.new }
    
    context "Class with normal method" do
      let(:klass){
        Class.new do
          include Eavesdropper::Eavesdroppable
          eavesdrop_on :one
          
          def one
          end
        end
      }
      
      it { should respond_to "one_with_logging" }
      it { should respond_to "one_without_logging" }
      it { should respond_to "one" }
    end

    context "Class with method that ends in a special character" do
      let(:klass){
        Class.new do
          include Eavesdropper::Eavesdroppable
          eavesdrop_on :one?
          
          def one?
          end
        end
      }

      it { should respond_to "one_with_logging?" }
      it { should respond_to "one_without_logging?" }
      it { should respond_to "one?" }
    end
    
    context "Class with private instance method" do
      let(:klass){
        Class.new do
          include Eavesdropper::Eavesdroppable
          eavesdrop_on :one
         
          private
          def one
            false
          end
        end
      }
        
      it { should_not respond_to "one_with_logging" }
      it { should_not respond_to "one_without_logging" }
      it { should_not respond_to "one" }
      specify { expect(subject.send :"one_with_logging").not_to be }
    end

    context "Eavesdroppable included after class definition" do
      before do
        klass.send :include, Eavesdropper::Eavesdroppable
        klass.eavesdrop_on(:one)
      end

      let(:klass) {
        Class.new do
          include Eavesdropper::Eavesdroppable
          eavesdrop_on :one
         
          def one
            false
          end
        end
      }

      it { should respond_to "one_with_logging" }
      it { should respond_to "one_without_logging" }
      it { should respond_to "one" }      
    end
  end
end
