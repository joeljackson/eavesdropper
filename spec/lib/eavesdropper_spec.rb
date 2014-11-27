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
      @result = Eavesdropper::Eavesdropper.new(object).call(method_name, *arguments, &block)
    end

    let(:object){ double("Object") }
    let(:block){ Proc.new {} }
    let(:arguments) { }
    
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
  end
end
