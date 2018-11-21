require 'spec_helper'

describe Lightspeed::Request do
  setup_client_and_account

  context 'with a request to get categories' do
    subject { described_class.new(client, method: :get, path: "/Account/0/Category.json") }

    context 'with a 502 Bad Gateway response that returns HTML' do
      # Response stubbed as VCR cassette not easily reproducible for testing
      let(:response) do
        instance_double(
          'Net::HTTPBadGateway',
          code: 502,
          body: "<html><head><title>502 Bad Gateway</title></head></html>"
        )
      end

      # We are testing the private method directly because we only care how it handles non-JSON responses
      it 'raises the appropriate lightspeed error' do
        expect { subject.send(:handle_error, response) }.to raise_error(Lightspeed::Error::InternalServerError, '502')
      end
    end
  end
end
