require './lib/eavesdropper'
require './lib/eavesdropper/eavesdropper'

describe Eavesdropper::Eavesdropper do
  before(:each) do
    @log_double = double("Logger")
    allow(@log_double).to receive(:add)
    
    allow(Eavesdropper).to receive(:logger).and_return(@log_double)
  end

  describe "#call" do
    before(:each) do
      setup
      begin
        @result = Eavesdropper::Eavesdropper.new(object).call(method_name, *arguments, &block)
      rescue StandardError => e
        @exception = e
      end
    end

    let(:setup){}
    let(:object){ double("Object") }
    let(:block){ Proc.new {} }
    let(:arguments){}
    
    context "Method that returns something" do
      let(:method_name){
        allow(object).to receive(:some_method).and_return("Hello world")
        :some_method
      }

      context "With no arguments" do
        specify { expect(object).to have_received(:some_method).with(no_args) }
        specify { expect(@result).to eq "Hello world" }
        specify { expect(@log_double).to have_received(:add) }
      end

      context "With two arguments" do
        let(:arguments) {
          ['a', 'b']
        }
        
        specify { expect(object).to have_received(:some_method).with('a', 'b') }
        specify { expect(@result).to eq "Hello world" }
        specify { expect(@log_double).to have_received(:add) }
      end
    end

    context "Method that modifies the object internally", pending: true do
      let(:method_name) {
        allow(object).to receive(:some_method) do |argument|
          @test = argument
        end
        :some_method
      }

      let(:arguments) { ['a'] }

      specify { expect(object.instance_variable_get(:"@test")).to eq arguments[0] }
    end

    context "Method that yields to a block" do
      let(:method_name) {
        allow(object).to receive(:some_method) do |&block|
          block.call
        end
        :some_method
      }

      let(:block) { 
        Proc.new do
          @test = "testing"
        end
      }

      specify { expect(@test).to eq "testing" }
    end

    context "Method that raises an exception" do
      let(:method_name) {
        allow(object).to receive(:some_method) do |&block|
          raise StandardError.new("Hello")
        end
        :some_method
      }

      specify { expect(@exception).not_to be_nil }
    end
  end
end
