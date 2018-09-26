require_relative 'collection'
require_relative 'transfer_item'

module Lightspeed
  class TransferItems < Lightspeed::Collection
    def base_path
      "#{account.base_path}/Inventory/Transfer"
    end

    def first(transferID:, params: {})
      super(params: params.merge(transferID: transferID, action: 'GET_SINGLE'))
    end

    def find(transferID:, itemID:)
      first(transferID: transferID, params: { itemID: itemID }) || handle_not_found(itemID)
    end

    def all(transferID:, params: {})
      super(params: params.merge(transferID: transferID, action: 'GET_ALL'))
    end

    def create(transferID:, **attributes)
      params = { transferID: transferID, action: 'ADD_ITEMS' }
      instantiate(post(params: params, body: Yajl::Encoder.encode(attributes))).first
    end

    def update(transferID:, **attributes)
      params = { transferID: transferID, action: 'UPDATE_MULTIPLE' }
      instantiate(post(params: params, body: Yajl::Encoder.encode(attributes))).first
    end

    def destroy(transferID:, **attributes)
      params = { transferID: transferID, action: 'DELETE' }
      instantiate(post(params: params, body: Yajl::Encoder.encode(attributes))).first
    end

    private

    def get(params: {})
      params = { load_relations: load_relations_default }
        .merge(context_params)
        .merge(params)
        .reject { |_, v| v.nil? }
      client.get(
        path: collection_path(params.dig(:transferID), params.dig(:action), params.dig(:itemID)),
        params: params
      )
    end

    def post(params: {}, body:)
      binding.pry
      client.post(
        path: collection_path(params.dig(:transferID), params.dig(:action)),
        body: body
      )
    end

    def collection_path(transfer_id, action, id = nil)
      path_ending = generate_action(action, id)

      "#{base_path}/#{transfer_id}/#{path_ending}.json"
    end

    def generate_action(action, id)
      case action
      when 'GET_ALL'
        'TransferItems'
      when 'GET_SINGLE'
        "TransferItems/#{id}"
      when 'ADD_ITEMS'
        'AddItems'
      when 'UPDATE_MULTIPLE'
        'UpdateItems'
      when 'DELETE'
        'DeleteItems'
      end
    end
  end
end
