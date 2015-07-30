module DummyClient
  def dummy_client
    Lightspeed::Client.new(api_key: 'test')
  end
end

RSpec.configure do |c|
  c.include DummyClient
end
