require_relative 'resource'

module Lightspeed
  class Transfer < Lightspeed::Resource
    fields(
      transferID: :integer,
      note: :string,
      archived: :boolean,
      timeStamp: :datetime,
      createTime: :datetime,
      status: :string,
      sentOn: :datetime,
      needBy: :datetime,
      sendingShopID: :integer,
      sentByEmployeeID: :integer,
      receivingShopID: :integer
    )

    def base_path
      if context.is_a?(Lightspeed::Collection)
        "#{context.base_path}/#{id}"
      else
        "#{account.base_path}/Inventory/#{resource_name}/#{id}"
      end
    end

    def send_transfer
      self.attributes = post(body: Yajl::Encoder.encode({}))[resource_name]
    end

    private

    def post(body:)
      client.post(
        path: resource_path.insert(-6, '/Send'),
        body: body
      )
    end
  end
end
