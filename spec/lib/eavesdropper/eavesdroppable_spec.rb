require './lib/eavesdropper'

describe Eavesdropper::Eavesdroppable do
  describe "self.included" do

    context "Class with normal method" do
      let(:klass){
        Class.new do
          include Eavesdropper::Eavesdroppable
          eavesdrop_on :one
          
          def one
          end
        end
      }
      
      context "The object" do
        subject { klass.new }
        
        it { should respond_to "one_with_logging" }
        it { should respond_to "one_without_logging" }
        it { should respond_to "one" }
      end
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
      
      context "The object" do
        subject { klass.new }
        
        it { should respond_to "one_with_logging?" }
        it { should respond_to "one_without_logging?" }
        it { should respond_to "one?" }
      end      
    end
  end
end
