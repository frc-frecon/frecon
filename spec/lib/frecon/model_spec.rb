require 'spec_helper'

require 'frecon/model'

describe FReCon::Model do
  describe '.controller' do
    it 'properly converts the class name to a controller name' do
      allow(FReCon::Model).to receive(:name) do 'FReCon::Test' end
      allow_any_instance_of(String).to receive(:constantize) do |instance| instance.to_s end

      expect(FReCon::Model.controller).to eq('FReCon::TestsController')
    end
  end

  describe '.descendants' do
    it 'calls ObjectSpace.each_object to find descendants' do
      expect(ObjectSpace).to receive(:each_object)
      allow(ObjectSpace).to receive(:each_object) { [] }

      FReCon::Model.descendants
    end

    it 'returns an Array with a count greater than zero' do
      require 'frecon/models'

      expect(FReCon::Model.descendants.count).not_to be(0)
    end
  end
end
