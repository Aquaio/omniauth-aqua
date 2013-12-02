require 'spec_helper'

describe OmniAuth::Strategies::Aqua do
  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }

  subject do
    args = ['appid', 'secret', @options || {}].compact
    OmniAuth::Strategies::Aqua.new(*args).tap do |strategy|
      strategy.stub(:request) {
        request
      }
    end
  end

  describe 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('aqua')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('http://api.aqua.io')
    end
  end

end
