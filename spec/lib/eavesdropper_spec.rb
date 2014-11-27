require './lib/eavesdropper'
require './lib/eavesdropper/eavesdropper'

describe Eavesdropper::Eavesdropper do
  describe "#call" do
    before(:each) do
      @log_double = double("Logger")
      allow(@log_double).to receive(:add)

      allow(Eavesdropper).to receive(:logger).and_return(@log_double)

      Eavesdropper::Eavesdropper.new(object).call(method_name, *arguments)
    end

    let(:object){ double("Object") }
    let(:method_name){
      allow(object).to receive(:some_method)
      :some_method
    }
    let(:arguments) {
      ['a', 'b']
    }

    specify { expect(object).to have_received(:some_method).with('a', 'b') }
    specify { expect(@log_double).to have_received(:add) }
  end
end
